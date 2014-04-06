print "Initializing game"
require 'gosu'
require 'wx'
require './smi'
include SMI
Dir["./colloquy/*.rb"].each do |file|
	require file
end

$GAMENAME = "whodunnit"
$WIDTH = 640
$HEIGHT = 480
$TILE = 32
$DEBUG = false
$VERBOSE = nil unless $DEBUG

print "."

def collision(player, object)
	pxmin = player.x
	pxmax = player.x + player.width
	pymin = player.y
	pymax = player.y + player.height
	oxmin = object.x
	oxmax = object.x + object.width
	oymin = object.y
	oymax = object.y + object.height
	hitsx = false
	hitsx ||= pxmin <= oxmin && oxmin <= pxmax
	hitsx ||= pxmin <= oxmax && oxmax <= pxmax
	hitsx ||= oxmin <= pxmin && pxmin <= oxmax
	hitsx ||= oxmin <= pxmax && pxmax <= oxmax
	hitsy = false
	hitsy ||= pymin <= oymin && oymin <= pymax
	hitsy ||= pymin <= oymax && oymax <= pymax
	hitsy ||= oymin <= pymin && pymin <= oymax
	hitsy ||= oymin <= pymax && pymax <= oymax
	return hitsx && hitsy && (player.room == object.room) && (player != object)
end

def touching(player, object)
	pxmin = player.x
	pxmax = player.x + player.width
	pymin = player.y
	pymax = player.y + player.height
	oxmin = object.x
	oxmax = object.x + object.width
	oymin = object.y
	oymax = object.y + object.height
	touchx = false
	touchx ||= 0 <= pxmin - oxmax && pxmin - oxmax <= 2 # doesn't touch to right of objects otherwise
	touchx ||= 0 <= oxmin - pxmax && oxmin - pxmax <= 1
	touchy = false
	touchy ||= 0 <= pymin - oymax && pymin - oymax <= 1
	touchy ||= 0 <= oymin - pymax && oymin - pymax <= 1
	hitsx = false
	hitsx ||= pxmin <= oxmin && oxmin <= pxmax
	hitsx ||= pxmin <= oxmax && oxmax <= pxmax
	hitsx ||= oxmin <= pxmin && pxmin <= oxmax
	hitsx ||= oxmin <= pxmax && pxmax <= oxmax
	hitsy = false
	hitsy ||= pymin <= oymin && oymin <= pymax
	hitsy ||= pymin <= oymax && oymax <= pymax
	hitsy ||= oymin <= pymin && pymin <= oymax
	hitsy ||= oymin <= pymax && pymax <= oymax
	return ((hitsx && touchy) || (hitsy && touchx)) && (player.room == object.room) && (player != object)
end

def room_id(room)
	case room
	when 1 then "home main floor"
	when 2 then "home upper floor"
	when 3 then "home basement"
	when 4 then "home front lawn"
	when 5 then "neighbor's lawn"
	when 6 then "garage at work"
	when 7 then "office floor"
	when 8 then "friend's lawn"
	when 9 then "coffee shop"
	when 0 then "friend's house"
	end
end

def transition(window, player, mode, target_ids, target_xs = [], target_ys = [])
	targets = ["Stay in this area"] + target_ids.map { |target| "Take #{mode} to #{room_id(target)}" }
	target = smi("Use #{mode}?", "Use #{mode}?", targets)
	if target != 0 && target != -1 then
		target -= 1
		window.setlevel(target_ids[target])
		player.tp(window, target_ids[target], target_xs[target], target_ys[target])
	end
end

class Entity
	attr_reader :x, :y, :width, :height, :room
	def hit(item)
		nil
	end
	def talk(item)
		nil
	end
end

class Drawable < Entity
	def initialize(window, x, y, image, room)
		@window = window
		@x = x
		@y = y
		@image = Gosu::Image.new(window, "res#{$TILE}/obj/#{image}.png")
		@width = @image.width
		@height = @image.height
		@room = room
	end
	def draw
		@image.draw(@x, @y, 1)
	end
end

class Anesthesia < Drawable
	def initialize(window, x, y, room)
		super(window, x, y, "anesthesia", room)
		@window = window
	end
	def talk(item)
		smi("Anesthesia", "You notice a bottle of anesthesia!", ["Continue, asking Graham about it."])
		@window.player.give(self)
		@window.hospital.meet
		@room = -1
		@window.graham.anesthesia1
	end
end

class Camera < Drawable
	def initialize(window, x, y, room)
		super(window, x, y, "camera", room)
		@window = window
	end
	def talk(item)
		if @window.player.has_a? Ladder then
			ladder = "The camera reveals the boss at work during the theft."
			conversation("Inspection: Camera", Hash["" => "You climb the ladder.", "View footage" => ladder, "OK" => 0], Hash["You climb the ladder." => ["View footage"], ladder => ["OK"]])
		else
			if @window.boss.met then
				noladder = "Too high.\nYou need a ladder to examine the camera."
			else
				noladder = "A security camera. Out of reach."
			end
			smi("Inspection: Camera", noladder, ["OK"])
		end
	end
end

class Plant < Drawable
	def initialize(window, room, x, y, note = false, code = 0)
		if note then
			super(window, x, y, "plantnote", room)
		else
			super(window, x, y, "plant", room)
		end
		@note = note
		case @note
		when 0
			@contents = "the first digit is #{code}"
		when 1
			@contents = "the second digit is #{code}"
		when 2
			@contents = "the third digit is #{code}"
		else
			@contents = ""
		end
	end
	def talk(item)
		if @note then
			contents = "The note reads: #{@contents}"
			lines = conversation("Inspection: Plant", Hash["" => "A plant with a note on it.", "OK" => 0, "Read note" => contents], Hash["A plant with a note on it." => ["Read note", "OK"], contents => ["OK"]])
			if lines.include? "Read note" then
				@window.player.give @contents
				@note = false
				@image = Gosu::Image.new(@window, "res#{$TILE}/obj/plant.png")
			end
		else
			smi("Inspection: Plant", "A plant.", ["OK"])
		end
	end
end

class Ladder < Drawable
	def initialize(window, x, y, room)
		super(window, x, y, "ladder", room)
	end
	def talk(item)
		if @window.boss.met then
			@window.player.give(self)
			@room = -1
			take = "You take the ladder. It might be useful."
			smi("Inspection: Ladder", take, ["OK"])
		else
			notake = "A ladder. Why? No clue."
			smi("Inspection: Ladder", notake, ["OK"])
		end
	end
end

class Briefcase < Drawable
	def initialize(window, x, y, room, code)
		super(window, x, y, "briefcase", room)
		@code = code
	end
	def talk(item)
		first  = smi("A briefcase, locked with a 3-digit code.", "Enter the first digit",  ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"])
		return if first == -1
		second = smi("A briefcase, locked with a 3-digit code.", "Enter the second digit", ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"])
		return if second == -1
		third  = smi("A briefcase, locked with a 3-digit code.", "Enter the third digit",  ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"])
		return if third == -1
		return if [first, second, third].include? -1
		code = first*100 + second*10+third
		if code == 404 || code == @code then
			brief_response = "Why...These are all details of the security system of art museum!\nShe's a thief, and she stole one of the most famous paintings in the entire country!\nWell, as much as I hate to admit it,\nif the pair of them were out stealing this thing last night,\nthey couldn't have had time to steal my invention.\nThey're far from innocent,\nbut they're no longer suspects."
		else
			brief_response = "The briefcase remains locked."
		end
		smi("Inspection: Briefcase", brief_response, ["OK"])
	end
end

class Barricade < Entity
	def initialize(window, x, y, width, height, room)
		@window = window
		@x = x
		@y = y
		@width = width
		@height = height
		@room = room
	end
	def draw
		@window.draw_quad(x,y,Gosu::Color::BLACK,x,y+height,Gosu::Color::BLACK,x+width,y+height,Gosu::Color::BLACK,x+width,y,Gosu::Color::BLACK,1) if $DEBUG
		nil
	end
end

class Staircase < Entity
	attr_reader :target
	def initialize(window, x, y, room, target)
		@window = window
		if target > room then
			@image = Gosu::Image.new(window, "res#{$TILE}/obj/stairsup.png")
		else
			@image = Gosu::Image.new(window, "res#{$TILE}/obj/stairsdown.png")
		end
		@x = x
		@y = y
		@width = @image.width
		@height = @image.height
		@room = room
		@target = target
	end
	def draw
		@image.draw(@x, @y, 1)
	end
	def hit(item)
		transition(@window, item, "stairs", [@target])
	end
end

class Door < Entity
	attr_reader :target
	def initialize(window, is_y, is_far, dist, room, target)
		@window = window
		@image = Gosu::Image.new(window, "res#{$TILE}/obj/door.png")
		@width = @image.width
		@height = @image.height
		if is_y then
			if is_far then
				@x = $WIDTH-@width
				@y = dist
				@target_x = @width + 1
				@target_y = dist
			else
				@x = 0
				@y = dist
				@target_x = $WIDTH-2*@width - 1
				@target_y = dist
			end
		else
			if is_far then
				@x = dist
				@y = $HEIGHT-@height
				@target_x = dist
				@target_y = @height + 1
			else
				@x = dist
				@y = 0
				@target_x = dist
				@target_y = $HEIGHT-2*@height - 1
			end
		end
		@room = room
		@target = target
	end
	def draw
		@image.draw(@x, @y, 1)
	end
	def hit(item)
		transition(@window, item, "door", [@target], [@target_x], [@target_y])
	end
end

class Car < Entity
	attr_reader :target
	def initialize(window, x, y, room, targets)
		@window = window
		@image = Gosu::Image.new(window, "res#{$TILE}/obj/car.png")
		@x = x
		@y = y
		@width = @image.width
		@height = @image.height
		@room = room
		@targets = targets
	end
	def draw
		@image.draw(@x, @y, 1)
	end
	def hit(item)
		transition(@window, item, "car", @targets)
	end
end

class NPC < Entity
	attr_reader :met, :name
	def initialize(window, name, title, x, y, room, says, hears)
		@window = window
		@name = name
		@image = Gosu::Image.new(window, "res#{$TILE}/char/#{name}.png", false)
		@title = title
		@x = x
		@y = y
		@room = room
		@width = @image.width
		@height = @image.height
		@says = says
		@hears = hears
		@met = false
	end
	def draw
		@image.draw(@x,@y, 2)
	end
	def dialogue() # Overriden using singleton classes on every NPC
		conversation(@title, @says, @hears)
	end
	def talk(item)
		@met = true
		dialogue()
	end
end

class Player < Entity
	attr_reader :name, :gender, :inventory
	def initialize(window, name, gender, x, y)
		@window = window
		@room = @window.room
		@name = name
		@image_forward = Gosu::Image.new(window, "res#{$TILE}/player/hatlessfront.png", false)
		@image_backward = Gosu::Image.new(window, "res#{$TILE}/player/hatlessrear.png", false)
		@image_left = Gosu::Image.new(window, "res#{$TILE}/player/hatlessleft.png", false)
		@image_right = Gosu::Image.new(window, "res#{$TILE}/player/hatlessright.png", false)
		@image = @image_forward
		@gender = gender
		@x = x
		@y = y
		@dx = 0
		@dy = 0
		@speed = 1
		@inventory = []
		@skills = []
	end
	def width
		@image.width
	end
	def height
		@image.height
	end
	def tp(window, level, x = nil, y = nil)
		if window == @window then
			@room = level
			if x != nil and y != nil then
				@x = x

				@y = y
			end
			return true
		else
			return false
		end
	end

	def button_down(id)
		case id
		when Gosu::KbLeft, Gosu::GpLeft
			@dx -= @speed * 1.5
		when Gosu::KbRight, Gosu::GpRight
			@dx += @speed * 1.5
		when Gosu::KbUp, Gosu::GpUp
			@dy -= @speed
		when Gosu::KbDown, Gosu::GpDown
			@dy += @speed
		end
	end

	def button_up(id)
		case id
		when Gosu::KbLeft, Gosu::GpLeft
			@dx = 0
		when Gosu::KbRight, Gosu::GpRight
			@dx = 0
		when Gosu::KbUp, Gosu::GpUp
			@dy = 0
		when Gosu::KbDown, Gosu::GpDown
			@dy = 0
		end
	end

	def move
		@x += @dx
		@y += @dy

		# Checks collision with any item
		@window.items.each do |item|
			if collision(self, item) then
				@x -= @dx
				@y -= @dy
				hit(item)
				item.hit(self)
			end
		end

		# Enforces that player position will stay within the window:
		@x = [[@x,$WIDTH-@image.width].min,0].max
		@y = [[@y,$HEIGHT-@image.height].min,0].max
	end
	def draw
		if @dx < 0 then
			@image = @image_left
		elsif @dx > 0 then
			@image = @image_right
		elsif @dy > 0 then
			@image = @image_forward
		elsif @dy < 0 then
			@image = @image_backward
		else
			@image = @image_forward
		end
		@image.draw(@x,@y, 2)
	end
	def hit(item)
		@dx = 0
		@dy = 0
	end
	def talk(item)
		@dx = 0
		@dy = 0
	end
	def showinventory
		lines = []
		@inventory.each do |item|
			if item.is_a? String then
				lines << "A note which says #{item.inspect}."
			elsif item.is_a? Anesthesia
				lines << "Graham's half-empty bottle of anesthesia."
			else
				lines << "A #{item.class.to_s.downcase}."
			end
		end
		smi("Inventory", "List of items:", lines)
	end
	def give(item)
		if has? item
			return false
		else
			@inventory << item
			return true
		end
	end
	def has?(item)
		@inventory.include? item
	end
	def has_a?(hasclass)
		@inventory.each do |item|
			return true if item.is_a? hasclass
		end
		return false
	end
end

class GameWindow < Gosu::Window
	attr_accessor :items
	attr_reader :room, :player, :mother, :boss, :graham, :andrew, :cynthia, :eli, :briefcase, :hospital
	def initialize
		super($WIDTH, $HEIGHT, false) # width, height, isfullscreen
		self.caption = $GAMENAME

		setlevel(2)

		@items = []

		@player = Player.new(self, "HAM", true, $WIDTH/2,$HEIGHT/2)
		@items << @player

		@mother = NPC.new(self, "Mother", "Mother", 250, 200, 1, Mother::Says, Mother::Hears)
		@items << @mother
		
		@boss = NPC.new(self, "Caleb", "Mr. Bossman", 156, 0, 7, Caleb::Says, Caleb::Hears)
		def @boss.dialogue
			conversation(@title, @says, @hears)
		end
		@items << @boss

		@graham = NPC.new(self, "Graham", "Graham", 200, 220, 0, Graham::Says, Graham::Hears)
		def @graham.anesthesia1
			@says = Graham::Says1
			@hears = Graham::Hears1
		end
		@items << @graham

		@andrew = NPC.new(self, "Andrew", "Andrew", 60, 180, 9, Andrew::Says, Andrew::Hears)
		def @andrew.go
			@room = -1
		end
		@items << @andrew

		@cynthia = NPC.new(self, "Cynthia", "Cynthia", 120, 180, 9, Cynthia::Says, Cynthia::Hears)
		def @cynthia.dialogue
			conversation(@title, @says, @hears)
			@room = -1
			@andrew.go
			@briefcase.go
		end
		@items << @cynthia

		@eli = NPC.new(self, "Eli", "Eli", 340,60,5, Eli::Says, Eli::Hears)
		@items << @eli

		@hospital = Barricade.new(self, 0,0,0,0,-1) # VERY HAX
		def @hosptial.met
			return false
		end
		def @hospital.meet
			def self.met
				return true
			end
		end
		def @hospital.name
			return "Hosptial"
		end
		def @hospital.talk(item)
			conversation("Hospital", Hospital::Says, Hospital::Hears)
		end
		@items << @hospital

		@items << Anesthesia.new(self, 180, 130, 0)
		@items << Camera.new(self, 0, 200, 7)
		@items << Ladder.new(self, 280, -20, 6)

		code = []
		code[0] = rand(10)
		code[1] = rand(10)
		code[2] = rand(10)

		@items << Plant.new(self, 4, 80, 100, 0, code[0])
		@items << Plant.new(self, 4, 120, 100)
		@items << Plant.new(self, 5, 480, 100)
		@items << Plant.new(self, 5, 520, 100)
		@items << Plant.new(self, 5, 560, 100)
		@items << Plant.new(self, 8, 50, 130)
		@items << Plant.new(self, 8, 90, 130)
		@items << Plant.new(self, 8, 130, 130, 1, code[1])
		@items << Plant.new(self, 9, 220, 20)
		@items << Plant.new(self, 9, 180, 20, 2, code[2])
		@items << Plant.new(self, 9, 140, 20)
		@items << Plant.new(self, 9, 100, 20)
		@items << Plant.new(self, 9, 60, 20)
		
		code = code[0]*100+code[1]*10+code[2]
		@briefcase = Briefcase.new(self, 120, 180, -1, code)
		def @briefcase.go
			@room = 9
		end
		@items << @briefcase

		@items << Staircase.new(self, 570, 120, 1, 2)
		@items << Staircase.new(self, 570, 120, 2, 1)
		@items << Staircase.new(self, 64, 280, 1, 3)
		@items << Staircase.new(self, 64, 280, 3, 1)
		@items << Door.new(self, false, true, 280, 1, 4)
		@items << Door.new(self, false, false, 280, 4, 1)
		@items << Door.new(self, true, false, 210, 4, 5)
		@items << Door.new(self, true, true, 210, 5, 4)
		@items << Door.new(self, false, false, 180, 6, 7)
		@items << Door.new(self, false, true, 180, 7, 6)
		@items << Door.new(self, false, true, 280, 0, 8)
		@items << Door.new(self, false, false, 280, 8, 0)
		@items << Car.new(self, 460, 250, 4, [6,8,9])
		@items << Car.new(self, 460, 250, 6, [4,8,9])
		@items << Car.new(self, 460, 250, 8, [4,6,9])
		@items << Car.new(self, 460, 250, 9, [4,6,8])

		conversation("Tutorial", Tutorial::Says, Tutorial::Hears)
	end
	def update
		@player.move
	end
	def draw
		@items.each do |item|
			if item.room == @room then
				item.draw
			end
		end
		@background_image.draw(0,0,0)
	end
	def button_down(id)
		case id
		when Gosu::KbEscape, Gosu::GpButton6
			close
		when Gosu::KbEnter, Gosu::KbSpace, Gosu::KbReturn
			@items.each do |item|
				if touching(@player, item) then
					@player.talk(item)
					item.talk(@player)
				end
			end
		when Gosu::KbBacktick
			$DEBUG = true
		when Gosu::Kb0
			setlevel(0) if $DEBUG
			@player.tp(self, 0) if $DEBUG
		when Gosu::Kb1
			setlevel(1) if $DEBUG
			@player.tp(self, 1) if $DEBUG
		when Gosu::Kb2
			setlevel(2) if $DEBUG
			@player.tp(self, 2) if $DEBUG
		when Gosu::Kb3
			setlevel(3) if $DEBUG
			@player.tp(self, 3) if $DEBUG
		when Gosu::Kb4
			setlevel(4) if $DEBUG
			@player.tp(self, 4) if $DEBUG
		when Gosu::Kb5
			setlevel(5) if $DEBUG
			@player.tp(self, 5) if $DEBUG
		when Gosu::Kb6
			setlevel(6) if $DEBUG
			@player.tp(self, 6) if $DEBUG
		when Gosu::Kb7
			setlevel(7) if $DEBUG
			@player.tp(self, 7) if $DEBUG
		when Gosu::Kb8
			setlevel(8) if $DEBUG
			@player.tp(self, 8) if $DEBUG
		when Gosu::Kb9
			setlevel(9) if $DEBUG
			@player.tp(self, 9) if $DEBUG
		when Gosu::KbA
			target = smi("Accusations:", "Accusations?", ["No accusation now", "Mother", "Mr. Caleb Bossman", "Neighbor Eli Goldrobe", "Friend Graham", "Cynthia Chapeau", "Professor Andrew Reactor"])
			case target
			when 0, -1
				return
			when 3
				sni("Outcome", "You Win")
				close
			else
				sni("Outcome", "You Lose")
				close
			end
		when Gosu::KbP
			names = ["Do not telephone"]
			contacts = [nil]
			@items.each do |item|
				if (item.respond_to? :met) && (item.met)
					contacts << item
					names << item.name
				end
			end
			contacts << nil # so that if smi returns -1 then target is nil
			target = contacts[smi("Telephone:", "Whom to call?", names)]
			return if target.nil?
			target.talk(@player)
		when Gosu::KbI
			@player.showinventory
		end
		@player.button_down(id)
	end
	def button_up(id)
		@player.button_up(id)
	end
	def setlevel(level)
		@room = level
		@background_image = Gosu::Image.new(self, "res#{$TILE}/bg/room#{@room}.png", false)
	end
end

class MenuApp < Wx::App
	def on_init
		window = GameWindow.new
		puts "."
		window.show
		puts "Closing game"
	end
end

print "."
unless defined?(Ocra)
	app = MenuApp.new
	app.main_loop
end
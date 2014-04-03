require 'gosu'
$width = 640
$height = 480
$TILE = 32

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

class Block
	attr_accessor :height, :width, :x, :y
	def initialize (window, height, length, x, y, isspecial)
		@window = window
		@x = x
		@y = y
		@length = length
		@color = Gosu::Color::GREEN
		@color = Gosu::Color::RED if isspecial
	end
	def update
		(0..length-1).to_a.each do |square|
			if @isvertical then
				@window.grid[x+square][y] = self
			end
		end
	end
	def draw
		x = @x * $TILE
		y = @y * $TILE
		height = @height * $TILE
		width = @width * $TILE
		@window.draw_quad(x,y,Gosu::Color::BLACK,x,y+height,@color,x+width,y+height,@color,x+width,y,@color,1)
	end
end

class Minigamewindow < Gosu::Window
	attr_accessor :blocks, :grid
	def initialize(width, height)
		super(width, height, false)
		self.caption = "Camera Hacking"
		@grid = Array.new(20, Array.new(15))
		@blocks = []
		@blocks << Block.new(self, 1, 2, 2, 2, true)
		@blocks << Block.new(self, 2, 1, 0, 0, false)
		@blocks << Block.new(self, 1, 3, 1, 0, false)
		@blocks << Block.new(self, 1, 3, 1, 1, false)
		@blocks << Block.new(self, 3, 1, 4, 1, false)
		@blocks << Block.new(self, 3, 1, 1, 2, false)
		@blocks << Block.new(self, 1, 2, 2, 3, false)
		@blocks << Block.new(self, 1, 3, 0, 5, false)
		@blocks << Block.new(self, 2, 1, 3, 4, false)
		@blocks << Block.new(self, 1, 2, 4, 4, false)
	end
	def needs_cursor?
		true
	end
	def draw
		@blocks.each do |block|
			block.draw
		end
#		@background_image.draw(0,0,0)
	end
	def button_down(id)
		case id
		when Gosu::MsLeft
			moose_x = (mouse_x / $TILE).floor
			moose_y = (mouse_y / $TILE).floor
			if @isholding then
				stop = false
				@blocks.each do |block|
					stop ||= collision(@holding, block) unless @holding = block
				end
				unless stop then
					if @holding.height == 1 && @isholding then
						@holding.x = moose_x
					else
						@holding.y = moose_y
					end
					@isholding = false
				end
			else
				@blocks.each do |check|
					if ((moose_x >= check.x && moose_x <= (check.x + check.width)) && (moose_y >= check.y && moose_y <= (check.y + check.height)))
					then
						@isholding = true
						@holding = check
					end
				end
			end
		end
	end
	def button_up(id)
		case id
		when Gosu::MsLeft
			@isholding = false
		end
	end
	def update
		@grid = Array.new(20, Array.new(15))
		@blocks.each do |block|
			block.update
		end		
	end
end


minigamewindow = Minigamewindow.new($width, $height).show
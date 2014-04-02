require 'gosu'
$width = 640
$height = 480
$TILE = 32

class Block
	attr_accessor :height, :length, :x, :y
	def initialize (window, height, length, x, y, isspecial)
		@window = window
		@height = height*$TILE
		@width = length*$TILE
		@x = x*$TILE
		@y = y*$TILE
		@color = Gosu::Color::GREEN
		@color = Gosu::Color::RED if isspecial
	end
	def draw
		@window.draw_quad(@x,@y,Gosu::Color::BLACK,@x,@y+@height,@color,@x+@width,@y+@height,@color,@x+@width,@y,@color,1)

	end
end

class Minigamewindow < Gosu::Window
	attr_accessor :blocks
	def initialize(width, height)
		super(width, height, false)
		self.caption = "Camera Hacking"
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
	def draw
		@blocks.each do |item|
			item.draw
		end
#		@background_image.draw(0,0,0)
	end

	def update
	end
end


minigamewindow = Minigamewindow.new($width, $height).show
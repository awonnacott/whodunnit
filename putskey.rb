require 'gosu'
class GameWindow < Gosu::Window
  def initialize
    super(640, 480, false) # width, height, isfullscreen
  end
  def update
  end
  def draw
  end
  def button_down(id)
    p id
  	puts "GpButton0" if id == Gosu::GpButton0
    puts "GpButton1" if id == Gosu::GpButton1
    puts "GpButton2" if id == Gosu::GpButton2
    puts "GpButton3" if id == Gosu::GpButton3
    puts "GpButton4" if id == Gosu::GpButton4
    puts "GpButton5" if id == Gosu::GpButton5
    puts "GpButton6" if id == Gosu::GpButton6
    puts "GpButton7" if id == Gosu::GpButton7
    puts "GpButton8" if id == Gosu::GpButton8
    puts "GpButton9" if id == Gosu::GpButton9
    puts "GpButton10" if id == Gosu::GpButton10
    puts "GpButton11" if id == Gosu::GpButton11
    puts "GpButton12" if id == Gosu::GpButton12
    puts "GpButton13" if id == Gosu::GpButton13
    puts "GpButton14" if id == Gosu::GpButton14
    puts "GpButton15" if id == Gosu::GpButton15
  end
end

window = GameWindow.new
window.show

the_stuff = {}

class THE_STUFF
  attr_accessor :freqs, :total

  def initialize
    @freqs = []
    @total = 0
  end
end

def do_the_thing()
  stuff = THE_STUFF.new
  def process_input(stuff)
    File.open("input1.txt").readlines.each do |line|
      sign = line[0]
      line[0] = ''
      line = line.to_i
      case sign
      when '+'
        stuff.total += line
      when '-'
        stuff.total -= line
      end
      if stuff.total == 655
        puts "found"
      end
      if stuff.freqs.include? stuff.total
        puts "---"
        puts stuff.total
        return true
      else
        stuff.freqs << stuff.total
      end
    end
    return false
  end
  while(!process_input(stuff))
  end
end
do_the_thing()

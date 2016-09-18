class Card
 def initialize(number)
   @number = number
   @face_up = false
 end

 attr_reader :face_up, :number

 def ==(card2)
   self.number == card2.number
 end

 def hide
   @face_up = false
 end

 def reveal
   @face_up = true
 end
end

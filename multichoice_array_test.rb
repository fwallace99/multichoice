require 'test_helper'

class MultichoiceTest2 < Minitest::Test

  def possibles_is_array
    possibles = ['Cat Stevens', 'The Year of the Cat by Al Stevens, Seventies Man', 'Leo DiCaprio because his name is Leo', 'a tabby cat', 'None of the Above, they are all wrong']
    assert_equal('Array', possibles.class)

  end


end

require "multichoice/version"
#require "mturk"

module MultiChoice
  #takes Amazon MTurk's XML Spec file and adds the multiple choice elements with RADIO BUTTONS
  #please note that you can supply as many and as varied elements as you want
  #for each Human Intelligence Task or HIT.

  #Arguments: over_view_text is the overview for the Question you are asking Mturkers
  #identifier: format "Your_Name - HitNumber", example "John_Smith-1"
  #question: format "something you want to ask", example "Which of these is a cat?"
  #possibles: format ['A tabby cat', 'Leo Di Caprio since his name is Leo', 'Cat Stevens', 'The Year of the Cat by Al Stewart because Seventies Man!', 'None of the Above']
  #possibles is the only argument that is NOT A STRING, but an array.
  #possibles must have AT LEAST ONE ARRAY ELEMENT, which is at least one possible answer to the question. But to make sense to the Mturker workers you should have at least two, i.e
  # possibles = ['The Band Stray Cats', 'None of the Above']
  class RadioButton

  def initialize(over_view_text, identifier, question, possibles)
    @over_view_text = over_view_text
    @identifier = identifier
    @question = question
    @possibles = possibles
  end

  def execute
    spitoutxml
  end

  def spitoutxml
    base_xml = <<HERE
<?xml version="1.0" encoding="UTF-8"?>
    <QuestionForm xmlns="http://mechanicalturk.amazonaws.com/AWSMechanicalTurkDataSchemas/2005-10-01/QuestionForm.xsd">
      <Overview>
      <Text>#{@over_view_text}</Text>
      </Overview>
      <Question>
HERE

    mylocal_identifier = "<QuestionIdentifier>#{@identifier}</QuestionIdentifier>"
    my_sku = "<QuestionContent>\n"
    my_sku = my_sku + "<Text>#{@question}</Text>\n"
    my_sku = my_sku + "</QuestionContent>\n"
    base_xml = base_xml + mylocal_identifier + my_sku

    top_answer_spec = <<ANS1
         <AnswerSpecification>
         <SelectionAnswer>
      <StyleSuggestion>radiobutton</StyleSuggestion>
      <Selections>
ANS1

    base_xml = base_xml + top_answer_spec
    my_answer = ''


    @possibles.each do |myelement|

        my_answer_spec = "<Selection>\n"
        spec_ident = "<SelectionIdentifier>#{myelement}</SelectionIdentifier>\n"
        sel_text = "<Text>#{myelement}</Text>\n"
        close_spec = "</Selection>\n"
        my_temp = my_answer_spec + spec_ident + sel_text + close_spec
        my_answer = my_answer + my_temp

       end


    base_xml = base_xml + my_answer

    bottom_answer = <<BOTTOM


      </Selections>
    </SelectionAnswer>
       </AnswerSpecification>
      </Question>
    </QuestionForm>
BOTTOM
    base_xml = base_xml + bottom_answer

    return base_xml
  end


 end
end

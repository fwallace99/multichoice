# Multichoice

The gem takes Amazon MTurk's XML Spec file and adds the multiple choice elements with RADIO BUTTONS
please note that you can supply as many and as varied elements as you want
for each Human Intelligence Task or HIT.

The Gem was written to enable users to rapidly create a Human Intelligence Task that has RADIO BUTTONS.

#Arguments:
  *over_view_text is the overview for the Question you are asking Mturkers
  *identifier: format "Your_Name - HitNumber", example "John_Smith-1"
  *question: format "something you want to ask", example "Which of these is a cat?"
  *possibles: format ['A tabby cat', 'Leo Di Caprio since his name is Leo', 'Cat Stevens', 'The Year of the Cat by Al Stewart because Seventies Man!', 'None of the Above']
  *possibles is the only argument that is NOT A STRING, but an array.
  *possibles must have AT LEAST ONE ARRAY ELEMENT, which is at least one possible answer to the question. But to make sense to the Mturker workers you should have at least two, i.e
  *possibles = ['The Band Stray Cats', 'None of the Above']

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'multichoice'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install multichoice

## Usage
Try this sample code out:

```ruby
require "multichoice"
require 'mturk'
require 'yaml'

module TestCreateHit
  class AmazonMturkHit

    def initialize
      read_config
      @mturk = Amazon::WebServices::MechanicalTurkRequester.new :Host => @T_Host, :AWSAccessKeyId => @T_AWSAccessKeyId, :AWSAccessKey => @T_AWSAccessKey

    end


    def read_config
      config = YAML.load_file("mturk.yaml")
      @T_Host = config["Host"]
      @T_AWSAccessKeyId = config["AWSAccessKeyId"]
      @T_AWSAccessKey = config["AWSAccessKey"]
    end


    def create_hit
      over_view_text = "This is a HIT to choose which of the following is a cat"
      identifier = "John_Smith-3"
      question = "Which of the following is a feline?"
      possibles = ['Cat Stevens', 'The Year of the Cat by Al Stewart, The Seventies Man', 'Leo DiCaprio because his name is Leo', 'a tabby cat', 'None of the Above, they are all wrong']
      my_xml = MultiChoice::RadioButton.new(over_view_text, identifier, question, possibles).execute
      available = @mturk.availableFunds.to_f
      puts "Available funds = #{available}"
      title = "Question about CATS"
      desc = "This is a HIT to answer questions about CATS"
      keywords = "cats, match"
      numAssignments = 1
      my_LifetimeInSeconds = 604800
      #one week lifetime
      #autoapproval = 5 days
      my_auto_approve = 60*60*24*5
      rewardAmount = 0.09 # 9 cents


      #create the HIT
      result = @mturk.createHIT( :Title => title,
          :Description => desc,
          :MaxAssignments => numAssignments,
          :LifetimeInSeconds => my_LifetimeInSeconds,
          :AutoApprovalDelayInSeconds => my_auto_approve,

          :Reward => { :Amount => rewardAmount, :CurrencyCode => 'USD' },
          :Question => my_xml,
          :Keywords => keywords )
      #---------------------
      #display Hit info
      puts "Created HIT: #{result[:HITId]}"
      myhit_id = result[:HITId]
      myhit_type_id = result[:HITTypeId]
      puts "HIT TYPE ID : #{myhit_type_id}"
      my_hit_location = getHITUrl(result[:HITTypeId])
      puts "HIT Location: #{getHITUrl( result[:HITTypeId])}"


    end


    def getHITUrl( hitTypeId )
        if @mturk.host =~ /sandbox/
            "http://workersandbox.mturk.com/mturk/preview?groupId=#{hitTypeId}"   # Sandbox Url
        else
             "http://mturk.com/mturk/preview?groupId=#{hitTypeId}"   # Production Url
        end
    end


  end
end

TestCreateHit::AmazonMturkHit.new.create_hit
```

## TODO

Still to come are checkboxes as well as radio buttons and retrieving the answer and parsing it for the good stuff.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/fwallace99/multichoice.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

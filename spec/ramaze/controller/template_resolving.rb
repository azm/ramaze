#          Copyright (c) 2006 Michael Fellinger m.fellinger@gmail.com
# All files in this distribution are subject to the terms of the Ruby license.

require 'spec/helper'

class MainController < Ramaze::Controller
  trait :template_root => "#{File.expand_path(File.dirname(__FILE__))}/template"
  
  def greet(type, message = "Message")
    @greet = "#{type} : #{message}"
  end
end

class OtherController < MainController
  trait :template_root => "#{File.expand_path(File.dirname(__FILE__))}/template/other"
  
  def greet__mom(message = "Moms are cool!")
    greet('Mom', message)
  end
  trait :greet__mom_template => '/greet'
end

describe "Testing Template overriding" do
  ramaze(:mapping => {'/' => MainController, '/other' => OtherController})

  it "simple request to greet" do
    get('/greet/asdf').should == '<html>asdf : Message</html>'
  end
  
  it "referencing template from MainController" do
    get('/other/greet/mom').should == '<html>Mom : Moms are cool!</html>'
  end

end
require File.dirname(__FILE__) + '/../../spec_helper'

describe Semantic::VectorSpace::Builder do

  before(:each) do
    stop_file = mock("file")
    stop_file.stub!(:read).and_return("the mouse")
  
    parser = stub("parser")
  
    Semantic::Parser.stub!(:new).and_return(parser)
    File.stub!(:open).and_yield(stop_file)
  end
  
  it "should tokenise the string documents" do
    parser = mock('parser')
    parser.stub!(:remove_stop_words).and_return(['mouse','trap'])
    parser.should_receive(:tokenise).twice.and_return(['mouse','trap'])
    Semantic::Parser.stub!(:new).and_return(parser)
  
    builder = Semantic::VectorSpace::Builder.new
    builder.build(['the mouse trap'])
  end

  it "should remove stopwords for string document" do
    parser = mock('parser')
    parser.stub!(:tokenise).and_return(['mouse','trap'])
    parser.should_receive(:remove_stop_words).twice.with(['mouse','trap']).and_return(['mouse'])
    Semantic::Parser.stub!(:new).and_return(parser)
  
    builder = Semantic::VectorSpace::Builder.new
    builder.build(['the mouse trap'])
  end

end

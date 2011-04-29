require "spec_helper"

require "feedback_test_helper"

describe Feedback::CaptchaController do
  render_views

  include FeedbackTestHelper

  it "should render the captcha image" do
    @cntl = mock :session => {}, :params => {}
    @cntl.should_receive(:response).and_return(response)
    @captcha = FeedbackCaptcha.new @cntl
    @captcha.generate_phrase 6
    code = @captcha.captcha_code
    @cntl.params[:path] = [code]
    WebivaCaptcha.should_receive(:new).and_return(@captcha)
    @captcha.should_receive(:generate_simple_captcha_image)
    get 'image', :path => [code]
    response.content_type.should == 'image/jpeg'
  end
end

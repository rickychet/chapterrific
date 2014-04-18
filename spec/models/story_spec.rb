require 'spec_helper'

describe Story do
  it { should respond_to(:title) }
  it { should respond_to(:body) }
  it { should respond_to(:genre) }
  it { should respond_to(:user_id) }
end

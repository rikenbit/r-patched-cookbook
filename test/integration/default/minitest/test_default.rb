require 'minitest/autorun'

describe 'check R version' do

  it "check R version" do
    system('R CMD BATCH showversion.R')
    assert system('grep "R version 3.2.0 alpha" showversion.Rout'), 'R version is not expected version. patched version is updated'
  end
end


require 'minitest/autorun'

describe 'check R version' do

  it "check R version" do
    system('R CMD BATCH showversion.R')
    assert system('grep "R version 3.1.0 Patched" showversion.Rout'), 'R version is not expected version. patched version is updated'
  end
end


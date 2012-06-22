require 'spec_helper'

describe Deal do
  before { @deal = Deal.make!(:complete) }
  subject { @deal }

  # Valid
  context 'when has valid attributes' do
    it { should be_valid }
  end

  # Validations
  context 'validations' do
    it { should have_valid(:close_date).when(Date.today, Date.today-1) }
    it { should_not have_valid(:close_date).when('a', nil, Date.today+1) }

    it { should have_valid(:category).when('raised funds from') }
    it { should_not have_valid(:category).when('invalid', '', nil) } 

    it { should have_valid(:round).when('Series A', '', nil) }
    it { should_not have_valid(:round).when('invalid') }

    it { should have_valid(:currency).when('USD', 'BRL', '', nil) }
    it { should_not have_valid(:currency).when('invalid') }

    it { should have_valid(:amount).when(1_000_000, '', nil) }
    it { should_not have_valid(:amount).when(-1, 42.0) } 

    it { should have_valid(:pre_valuation).when(10_000_000, '', nil) }
    it { should_not have_valid(:pre_valuation).when(-1, 42.0) }

    it { should have_valid(:source_url).when('http://techcrunch.com', '', nil) }
    it { should_not have_valid(:source_url).when('http://invalid') }

    it { should have_valid(:company_id).when(1000) } 
    it { should_not have_valid(:company_id).when('', nil) }    

    it "should not include target company as investor" do
      @deal.corporates << @deal.company
      @deal.should_not be_valid
    end 
  end

  # Associations
  context 'associations' do
    it { should belong_to(:company) }
    it { should have_many(:offerings) }
    it { should have_many(:investors).through(:offerings) } 
    it { should have_many(:corporates).through(:offerings) }           
  end

  # Methods
  context '#summary' do
    it { @deal.summary.should == "#{@deal.company_name} raised a #{@deal.round} round"\
      " of #{@deal.full_amount} from #{@deal.buyers_name}" }
  end

  context '#full_amount' do
    before do
      @deal.currency = 'BRL'
      @deal.amount = 1_000_000
    end
    it { @deal.full_amount.should == "BRL 1,000,000" }
  end

end












require 'spec_helper'

describe Deal do
  before(:each) { @deal = Deal.make! }
  subject { @deal }

  # Valid
  context 'when has valid attributes' do
    it { should be_valid }
  end

  # Validations
  context 'validations' do
    it { should have_valid(:deal_date).when(Date.today) }
    it { should_not have_valid(:deal_date).when('a', nil) }

    it { should have_valid(:category).when('financing round') }
    it { should_not have_valid(:category).when('invalid', '', nil) } 

    it { should have_valid(:round).when('Series A') }
    it { should_not have_valid(:round).when('invalid', '', nil) }

    it { should have_valid(:amount).when(1_000_000, nil) }
    it { should_not have_valid(:amount).when(-1, 42.0) }  # TODO: test blank

    it { should have_valid(:pre_valuation).when(10_000_000, nil) }
    it { should_not have_valid(:pre_valuation).when(-1, 42.0) }  # TODO: test blank

    it { should have_valid(:source_url).when('http://techcrunch.com', '', nil) }
    it { should_not have_valid(:source_url).when('http://invalid') }

    # it { should_not have_valid(:company_id).when(nil) }    
  end

  # Associations
  context 'associations' do
    it { should belong_to(:company) }
    it { should have_and_belong_to_many(:investors) }
  end

  # Methods
  context '#summary' do
    it { @deal.summary.should == "#{@deal.company_name} raised USD #{@deal.amount} from #{@deal.investor_name}." }
  end

end












require 'rails_helper'

describe Contact do
  it 'has valid factory' do
    expect(build(:contact)).to be_valid
  end

  it 'is valid with a firstname, lastname and email' do
    contact = build(:contact)
    contact.valid?
    expect(contact).to be_valid
  end

  it 'is invalid without a firstname' do
    contact = build(:contact, firstname: nil)
    contact.valid?
    expect(contact.errors[:firstname]).to include("can't be blank")
  end

  it 'is invalid without a lastname' do
    contact = build(:contact, lastname: nil)
    contact.valid?
    expect(contact.errors[:lastname]).to include("can't be blank")
  end

  it 'is invalid without an email address' do
    contact = build(:contact, email: nil)
    contact.valid?
    expect(contact.errors[:email]).to include("can't be blank")
  end

  it 'is invalid with a duplicate email address' do
    create(:contact, email: 'dev@example.com')
    contact = build(:contact, email: 'dev@example.com')
    contact.valid?
    expect(contact.errors[:email]).to include('has already been taken')
  end

  it "returns a contact's full name as a string" do
    contact = build(:contact, firstname: 'foo', lastname: 'bar')
    expect(contact.name).to eql 'foo bar'
  end

  describe 'filter last name with letter' do
    before :each do
      @sumon = create(:contact, lastname: 'sumon')
      @sajid = create(:contact, lastname: 'sajid')
      @tauhid = create(:contact, lastname: 'tauhid')
    end

    context 'with matching letter' do
      it 'return sorted array of results' do
        expect(Contact.by_letter('s')).to eq [@sajid, @sumon]
      end
    end

    context 'without matching letter' do
      it 'omit result without letter' do
        expect(Contact.by_letter('s')).not_to include @tauhid
      end
    end
  end
end

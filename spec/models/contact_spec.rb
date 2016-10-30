require 'rails_helper'

describe Contact do
  it 'is valid with a firstname, lastname and email' do
    contact = Contact.new(email: 'example@gmail.com', firstname: 'foo', lastname: 'bar')
    contact.valid?
    expect(contact).to be_valid
  end

  it 'is invalid without a firstname' do
    contact = Contact.new
    contact.valid?
    expect(contact.errors[:firstname]).to include("can't be blank")
  end

  it 'is invalid without a lastname' do
    contact = Contact.new(lastname: nil)
    contact.valid?
    expect(contact.errors[:lastname]).to include("can't be blank")
  end

  it 'is invalid without an email address' do
    contact = Contact.new(email: nil)
    contact.valid?
    expect(contact.errors[:email]).to include("can't be blank")
  end

  it 'is invalid with a duplicate email address' do
    Contact.create email: 'dev@example.com', firstname: 'foo', lastname: 'bar'
    contact = Contact.new email: 'dev@example.com', firstname: 'foo', lastname: 'bar'
    contact.valid?
    expect(contact.errors[:email]).to include('has already been taken')
  end

  it "returns a contact's full name as a string" do
    contact = Contact.create email: 'dev@example.com', firstname: 'foo', lastname: 'bar'
    expect(contact.name).to eql 'foo bar'
  end

  describe 'filter last name with letter' do
    before :each do
      @sumon = Contact.create email: 'sumon@example.com', firstname: 'hasanuzzaman', lastname: 'sumon'
      @sajid = Contact.create email: 'sajid@example.com', firstname: 'Rabbany', lastname: 'sajid'
      @tauhid = Contact.create email: 'tauhid@example.com', firstname: 'Islam', lastname: 'tauhid'
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

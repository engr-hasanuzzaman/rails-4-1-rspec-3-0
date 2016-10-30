require 'rails_helper'

describe Phone do
  it 'does not allow duplicate phone number per contact' do
    contact =Contact.create email: 'dev@example.com', firstname: 'foo', lastname: 'bar'
    Phone.create(contact: contact, phone: '0123456', phone_type: 'home')
    phone = Phone.new(contact: contact, phone: '0123456', phone_type: 'office')
    phone.valid?
    expect(phone.errors[:phone]).to include('has already been taken')
  end

  it 'allow same phone number for different contact' do
    contact1 = Contact.create email: 'dev@example.com', firstname: 'foo', lastname: 'bar'
    contact2 = Contact.create email: 'dev2@example.com', firstname: 'foo', lastname: 'bar'

    Phone.create(contact: contact1, phone: '0123456', phone_type: 'home')
    phone = Phone.new(contact: contact2, phone: '0123456', phone_type: 'home')
    phone.valid?
    expect(phone).to be_valid
  end
end
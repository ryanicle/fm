class Friend < ApplicationRecord
  belongs_to :sender, :class_name => 'User', :foreign_key => :sender_id
  belongs_to :recipient, :class_name => 'User', :foreign_key => :recipient_id

  def self.request_friend(sender_id, recipient_id)
    @sender = self.where(sender_id: sender_id, recipient_id: recipient_id).first

    @recipient = self.where(sender_id: recipient_id, recipient_id: sender_id).first

    unless @sender
      @sender = self.new(sender_id: sender_id, recipient_id: recipient_id)
      @sender.current_status = 'approved'
      @sender.current_status_at = Time.now
      @sender.friendship = true
      @sender.friendship_at = Time.now
      @sender.subscribed = true
      @sender.subscribed_at = Time.now
    end

    unless @recipient
      @recipient = self.new(sender_id: recipient_id, recipient_id: sender_id)
      @recipient.current_status = 'approved'
      @recipient.current_status_at = Time.now
      @recipient.friendship = true
      @recipient.friendship_at = Time.now
      @recipient.subscribed = true
      @recipient.subscribed_at = Time.now
    end

    if @sender.save && @recipient.save
      true
    else
      false
    end
  end

  def self.friends(user_id)
    Friend.where(sender_id: user_id).pluck(:email)
  end

  def self.common_friends(friend_emails)
    @sender = User.where(email: friend_emails[0]).first
    @recipient = User.where(email: friend_emails[1]).first

    @sender_friends = self.where(sender_id: @sender.id)
    @recipient_friends = self.where(sender_id: @recipient.id)

    @emails = []
    @sender_friends.each do |sender_friend|
      @recipient_friends.each do |recipient_friend|
        if (sender_friend.recipient.email == recipient_friend.recipient.email)
          @emails.push(sender_friend.recipient.email)
        end
      end
    end
    return @emails
  end

  def self.subscribe_friend(sender_email, recipient_email)
    @sender = User.where(email: sender_email).first
    @recipient = User.where(email: recipient_email).first

    @sender_friend = self.where(sender_id: @sender.id, recipient_id: @recipient.id).first_or_create
    @recipient_friend = self.where(sender_id: @recipient.id, recipient_id: @sender.id).first_or_create

    unless @recipient_friend.nil?
      @recipient_friend.update_attributes(subscribed: true, subscribed_at: Time.now)
    else
      false
    end
  end

  def self.unsubscribe_friend(sender_email, recipient_email)
    @sender = User.where(email: sender_email).first
    @recipient = User.where(email: recipient_email).first

    @sender_friend = self.where(sender_id: @sender.id, recipient_id: @recipient.id).first

    unless @sender_friend.nil?
      @sender_friend.update_attributes(subscribed: true, subscribed_at: Time.now)
    else
      false
    end
  end

  def self.can_receive_updates(sender_email, text)
    @sender = User.where(email: sender_email).first

    @friends = self.where(sender_id: @sender.id, subscribed: true)
    @emails = []

    @friends.each do |friend|
      @emails.push(friend.recipient.email)
    end
    # Merge two arrays into one
    @emails = @emails | self.extract_emails_to_array(text)
    @emails
  end

  def self.extract_emails_to_array(text)
    reg_exp = /[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}/i
    text.scan(reg_exp).uniq
  end
end

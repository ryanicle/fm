class Api::V1::FriendsController < Api::V1::ApplicationController
  # Create a connection between two friends
  # GET /api/v1/add.json
  def add
    sender = User.where(email: params[:friends][0]).first
    recipient = User.where(email: params[:friends][1]).first
    if Friend.request_friend(sender.id, recipient.id)
      render json: { success: true }
    end
  end

  # Find list of friends for a user
  # GET /api/v1/list.json
  def list
    @emails = Friend.friends(params[:email])

    unless @emails.empty?
      render json:{
        success: true,
        friends: @emails,
        count: @emails.count
      }
    else
      render json: {
        success: false,
        friends: [],
        count: 0
      }
    end
  end

  # Find friends that are commond between two friends
  # GET /api/v1/common.json
  def common
    @emails = Friend.common_friends(params[:friends])

    unless @emails.empty?
      render json: {
        success: true,
        friends: @emails,
        count: @emails.count
      }
    else
      render json: {
        success: false,
        friends: [],
        count: 0
      }
    end
  end

  # Subscribe friend and will receive updates
  # POST /api/v1/subscribe.json
  def subscribe
    if Friend.subscribe_friend(params[:requestor], params[:target])
      render json: {
        success: true
      }
    else
      render json: {
        success: false
      }
    end
  end

  # Block and unsubscribe friend for updates and will not receive updates
  # PUT /api/v1/unsubscribe
  def unsubscribe
    if Friend.unsubscribe_friend(params[:requestor], params[:target])
      render json: {
        success: true
      }
    else
      render json: {
        success: false
      }
    end
  end

  # Retrieve email addresses that can receive updates
  # GET api/v1/receive_updates.json
  def updates
    @recipients = Friend.can_receive_updates(params[:sender], params[:text])

    unless @recipients.nil?
      render json: {
        success: true,
        recipients: @recipients
      }
    else
      render json: {
        success: false,
        recipients: @recipients
      }
    end
  end
end

module Manage
  class InvitesController < ActiveUsersController
    before_action :set_invite, only: [:show, :edit, :update, :destroy]

    # GET /invites
    # GET /invites.json
    def index
      @invite = Invite.new
      @invites = Invite.all
    end

    # GET /invites/1
    # GET /invites/1.json
    def show
    end

    # GET /invites/new
    def new
      @invite = Invite.new
    end

    # GET /invites/1/edit
    def edit
    end

    # POST /invites
    # POST /invites.json
    def create
      @invite = Invite.create(created_by: active_user.id)
       redirect_to manage_invites_path
       flash[:message] =  'Invite was successfully created.'
    end

    def approve
      @invite = Invite.find(params[:id])
      unless @invite.sent?
        NotifierMailer.new_story_code_created(@invite.id).deliver
      end

      @invite.sent=true
      @invite.save

      flash[:message] =  'Invite was approved and sent to user.'
      redirect_to manage_invites_path

    end
    # DELETE /invites/1
    # DELETE /invites/1.json
    def destroy
      @invite.destroy
      respond_to do |format|
        format.html { redirect_to manage_invites_url, notice: 'Invite was successfully destroyed.' }
        format.json { head :no_content }
      end
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_invite
        @invite = Invite.find(params[:id])
      end

      # Never trust parameters from the scary internet, only allow the white list through.
      def invite_params
        params.require(:invite).permit(:key, :used, :user_id, :used_on)
      end
  end
end

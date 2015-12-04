module Manage
  class InvitesController < SuperUserController
    before_action :set_invite, only: [:show, :edit, :update, :destroy]

    # GET /invites
    # GET /invites.json
    def index
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
      @invite = Invite.new
      @invite.key = SecureRandom.hex(6)

      respond_to do |format|
        if @invite.save
          format.html { redirect_to manage_invite_path(@invite), notice: 'Invite was successfully created.' }
          format.json { render :show, status: :created, location: @invite }
        else
          format.html { render :new }
          format.json { render json: @invite.errors, status: :unprocessable_entity }
        end
      end
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

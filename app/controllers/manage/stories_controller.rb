module Manage
  class StoriesController < ActiveUsersController
    before_action :set_story, only: [:show, :edit, :subscribers, :update, :destroy, :invitations, :send_invitations]
    before_action :get_users, only: [:new, :edit, :create, :update]

    # GET /stories
    # GET /stories.json
    def index
        @stories = active_user.active_authored_stories
        @completed_stories = active_user.completed_authored_stories
    end

    def subscribers
    end

    def all
      require_super_user_login
      @stories = Story.all
    end

    # GET /stories/1
    # GET /stories/1.json
    def show
    end

    # GET /stories/new
    def new
      @story = Story.new
    end

    # GET /stories/1/edit
    def edit
    end

    def request_code

    end

    def create_code
      @invite = Invite.new(user_requested: true, creator: active_user, user: active_user)

      if @invite.save
        NotifierMailer.new_story_code_request(user_name: active_user.full_name).deliver
        flash[:message] = "An invite code willbe sent to you at #{active_user.email}. Once you receive it, you can start your amazing story."
        redirect_to profile_path
      else
        flash[:message] = "Sorry but an invite code could not be created. Please try again later"
        redirect_to manage_request_code_path
      end
    end

    def invitations
      @invitations = @story.invitations
    end

    def send_invitations
      params[:email_list].each_line do | email |
        Resque.enqueue(InvitationWorker, email, params[:message], @story.id, active_user.id ) unless @story.invitations.find_by(email: email.strip)
      end
      flash[:message] = "Your invitations will be sent shortly. Refresh this page if they do not appear."
      redirect_to invitations_manage_story_path(@story)
    end
    # POST /stories
    # POST /stories.json
    def create
      @story = Story.new(story_params)
      @story.active = true
      @story.user = active_user

      respond_to do |format|
        if validate_invite
          if @story.save
            use_invite
            assign_author
            format.html { redirect_to manage_story_path(@story), notice: 'Story was successfully created.' }
            format.json { render :show, status: :created, location: @story }
          else
            format.html { render  :new }
            format.json { render json: @story.errors, status: :unprocessable_entity }
          end

        else
          @story.errors.add(:base, "must have a valid invite code")
          format.html { render  :new }
          format.json { render json: @story.errors, status: :unprocessable_entity }
        end
      end

    end



    # PATCH/PUT /stories/1
    # PATCH/PUT /stories/1.json
    def update
      respond_to do |format|
        if @story.update(story_params)
          format.html { redirect_to manage_story_path(@story), notice: 'Story was successfully updated.' }
          format.json { render :show, status: :ok, location: @story }
        else
          format.html { render :edit }
          format.json { render json: @story.errors, status: :unprocessable_entity }
        end
      end
    end

    # DELETE /stories/1
    # DELETE /stories/1.json
    def destroy
      @story.destroy
      respond_to do |format|
        format.html { redirect_to manage_stories_url, notice: 'Story was successfully destroyed.' }
        format.json { head :no_content }
      end
    end

    private

      def assign_author
        active_user.subscribe_to(@story, 'Author', {author: true})
      end

      # Use callbacks to share common setup or constraints between actions.
      def set_story
        @story = Story.find_by_permalink(params[:id])
      end

      def get_users
        @active_user = active_user
        @users || @users = User.all
      end

      # Never trust parameters from the scary internet, only allow the white list through.
      def story_params
        params.require(:story).permit(:name, :active, :about, :taxonomy, :teaser, :alert_on_vote, :completed)
      end

      def validate_invite
        return false unless params[:invite_code]
        @invite = Invite.find_by(key: params[:invite_code], used: false)
        return false unless @invite
        return true
      end

      def use_invite
        @invite.update(user_id: session[:user_id], used: true, used_on: DateTime.now) if @invite
      end
  end
end

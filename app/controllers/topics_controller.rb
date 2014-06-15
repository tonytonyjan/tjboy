class TopicsController < ApplicationController
  before_action :authenticate!, only: %i[new create edit update destroy]
  before_action :set_user
  before_action :set_topic, only: %i[show edit update destroy]
  before_action :chack_owner!, only: %i[edit update destroy]

  # GET /topics
  # GET /topics.json
  def index
    @topics = Topic.includes(:user).subscribed_by(@user).order('id DESC').page(params[:page])
  end

  # GET /topics/1
  # GET /topics/1.json
  def show
  end

  # GET /topics/new
  def new
    @topic = Topic.new
  end

  # GET /topics/1/edit
  def edit
  end

  # POST /topics
  # POST /topics.json
  def create
    @topic = current_user.topics.new(topic_params)
    @topic.subscriber = @user

    respond_to do |format|
      if @topic.save
        format.html { redirect_to [@user, @topic], notice: '成功新增' }
        format.json { render :show, status: :created, location: @topic }
      else
        format.html { render :new }
        format.json { render json: @topic.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /topics/1
  # PATCH/PUT /topics/1.json
  def update
    respond_to do |format|
      if @topic.update(topic_params)
        format.html { redirect_to [@user, @topic], notice: '成功更新' }
        format.json { render :show, status: :ok, location: @topic }
      else
        format.html { render :edit }
        format.json { render json: @topic.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /topics/1
  # DELETE /topics/1.json
  def destroy
    @topic.destroy
    respond_to do |format|
      format.html { redirect_to [@user, Topic], notice: '成功刪除' }
      format.json { head :no_content }
    end
  end

  def check
    render json: !!Regexp.new(params[:pattern]).match(params[:request])
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_topic
      @topic = Topic.find(params[:id])
    end

    def set_user
      @user = User.find_by(nick_name: params[:user_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def topic_params
      params.require(:topic).permit(:name, :pattern, responses_attributes: [:id, :_destroy, :content])
    end

    def chack_owner!
      redirect_to request.referer || root_path, alert: '權限不足' unless current_user.own_topic?(@topic)
    end
end

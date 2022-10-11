class QuestionsController < ApplicationController
  before_action :set_question, only: %i[update show destroy edit]
  # skip_before_action :verify_authenticity_token
  def create
    question = Question.create(question_params)

    # flash[:notice] = "Новый вопрос создан"
    redirect_to question_path(question.id), notice: "Новый вопрос создан!"
  end

  def update
    @question.update(question_params)
    redirect_to question_path(@question.id), notice: "Сохранили вопрос!"
  end

  def destroy
    @question.destroy
    redirect_to questions_path, notice: "Вопрос удалён!!"
  end

  def show
  end

  def index
    @question = Question.new
    @questions = Question.all
  end

  def new
    @question = Question.new
  end

  def edit
  end


  private

  def question_params
    params.require(:question).permit(:body, :user_id)
  end

  def set_question
    @question = Question.find(params[:id])
  end
end

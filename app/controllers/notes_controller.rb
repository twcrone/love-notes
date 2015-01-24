class NotesController < ApplicationController
  before_action :set_note, only: [:show, :edit, :update, :destroy, :send_message, :reset]

  # GET /
  def sent
    @notes = Note.where('sent_at IS NOT NULL').order('sent_at DESC').limit(10)
  end

  # GET /notes
  # GET /notes.json
  def index
    if params[:sent]
      @notes = Note.where('sent_at IS NOT NULL').order('sent_at DESC')
    else
      @notes = Note.where('sent_at IS NULL').order('created_at DESC')
    end
  end

  # GET /notes/1
  # GET /notes/1.json
  def show
  end

  # GET /notes/new
  def new
    @note = Note.new
  end

  # GET /notes/1/edit
  def edit
  end

  # POST /notes
  # POST /notes.json
  def create
    @note = Note.new(note_params)
    @note.created_at = DateTime.now

    respond_to do |format|
      if @note.save
        format.html { redirect_to @note, notice: 'Note was successfully created.' }
        format.json { render action: 'show', status: :created, location: @note }
      else
        format.html { render action: 'new' }
        format.json { render json: @note.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /notes/1/send_message
  def send_message

    LoveNoteSender.send_text_message(@note).deliver
    @note.sent_at = DateTime.now

    respond_to do |format|
      if @note.save
        format.html { redirect_to @note, notice: 'Note was successfully sent.' }
        format.json { render action: 'show', status: :ok, location: @note }
      else
        format.html { render action: 'show' }
        format.json { render json: @note.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /notes/send_unsent_message
  def send_unsent_message
    puts "Sending love note..."
    notes = Note.where('sent_at IS NULL')
    count = notes.length
    puts "Found #{count} unsent notes..."
    index = rand(count)
    puts "Picking note at index=#{index}"
    note = notes[index]

    if note
      puts "Sending note #{note.id}"
      LoveNoteSender.send_text_message(note).deliver
      puts "Sending #{note.message}..."
      note.sent_at = DateTime.now
      puts "Saving sent at #{note.sent_at}..."
      note.save
    else
      puts 'No pending notes found.'
    end

    respond_to do |format|
      if note
        format.html { redirect_to note, notice: 'Note was successfully sent.' }
        format.json { render action: 'show', status: :ok, location: note }
      else
        format.html { render action: 'show' }
        format.json { render json: note.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /notes/1
  # PATCH/PUT /notes/1.json
  def update
    respond_to do |format|
      if @note.update(note_params)
        format.html { redirect_to @note, notice: 'Note was successfully updated.' }
        format.json { render action: 'show', status: :ok, location: @note }
      else
        format.html { render action: 'edit' }
        format.json { render json: @note.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /notes/1/reset
  def reset
    @note.sent_at = nil
    respond_to do |format|
      if @note.save
        format.html { redirect_to @note, notice: 'Note was successfully reset.' }
        format.json { render action: 'show', status: :ok, location: @note }
      else
        format.html { render action: 'edit' }
        format.json { render json: @note.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /notes/1
  # DELETE /notes/1.json
  def destroy
    @note.destroy
    respond_to do |format|
      format.html { redirect_to notes_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_note
      @note = Note.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def note_params
      params.require(:note).permit(:message, :created_at, :sent_at)
    end
end

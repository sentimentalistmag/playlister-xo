require 'spec_helper'
require 'pry'
describe SongsController do

  # This should return the minimal set of attributes required to create a valid
  # Song. As you add validations to Song, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) { FactoryGirl.attributes_for(:song) }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # SongsController. Be sure to keep this updated too.
  let(:valid_session) { {} }
  before(:each) do
    sign_in FactoryGirl.create(:user)
  end
  describe "GET index" do
    it "assigns all songs as @songs" do
      song = Song.create! valid_attributes
      get :index, {}, valid_session
      assigns(:songs).should eq([song])
    end
  end

  describe "GET show" do
    it "assigns the requested song as @song" do
      song = Song.create! valid_attributes
      get :show, {:id => song.to_param}, valid_session
      assigns(:song).should eq(song)
    end
  end

  describe "GET new" do
    it "assigns a new song as @song" do
      get :new, {}, valid_session
      assigns(:song).should be_a_new(Song)
    end
  end

  describe "GET edit" do
    it "assigns the requested song as @song" do
      song = Song.create! valid_attributes
      get :edit, {:id => song.to_param}, valid_session
      assigns(:song).should eq(song)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Song" do
        expect {
          post :create, {:song => valid_attributes}, valid_session
        }.to change(Song, :count).by(1)
      end

      it "assigns a newly created song as @song" do
        post :create, {:song => valid_attributes}, valid_session
        assigns(:song).should be_a(Song)
        assigns(:song).should be_persisted
      end

      it "redirects to the jukebox library" do
        post :create, {:song => valid_attributes}, valid_session
        response.should redirect_to(songs_path)
      end

      it "creates with an artist name" do
        post :create, {song: valid_attributes}, valid_session
        response.should redirect_to(songs_path)
        song = Song.first
        expect(song.title).to eq valid_attributes[:title]
        expect(song.artist_name).to eq(valid_attributes[:artist_name])
      end

    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved song as @song" do
        # Trigger the behavior that occurs when invalid params are submitted
        Song.any_instance.stub(:save).and_return(false)
        post :create, {:song => { "title" => "invalid value" }}, valid_session
        assigns(:song).should be_a_new(Song)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Song.any_instance.stub(:save).and_return(false)
        post :create, {:song => { "title" => "invalid value" }}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested song" do
        song = Song.create! valid_attributes
        # Assuming there are no other songs in the database, this
        # specifies that the Song created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Song.any_instance.should_receive(:update).with({ "title" => "MyString" })
        put :update, {:id => song.to_param, :song => { "title" => "MyString" }}, valid_session
      end

      it "assigns the requested song as @song" do
        song = Song.create! valid_attributes
        put :update, {:id => song.to_param, :song => valid_attributes}, valid_session
        assigns(:song).should eq(song)
      end

      it "redirects to the song" do
        song = Song.create! valid_attributes
        put :update, {:id => song.to_param, :song => valid_attributes}, valid_session
        response.should redirect_to(song)
      end
    end

    describe "with invalid params" do
      it "assigns the song as @song" do
        song = Song.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Song.any_instance.stub(:save).and_return(false)
        put :update, {:id => song.to_param, :song => { "title" => "invalid value" }}, valid_session
        assigns(:song).should eq(song)
      end

      it "re-renders the 'edit' template" do
        song = Song.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Song.any_instance.stub(:save).and_return(false)
        put :update, {:id => song.to_param, :song => { "title" => "invalid value" }}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested song" do
      song = Song.create! valid_attributes
      expect {
        delete :destroy, {:id => song.to_param}, valid_session
      }.to change(Song, :count).by(-1)
    end

    it "redirects to the songs list" do
      song = Song.create! valid_attributes
      delete :destroy, {:id => song.to_param}, valid_session
      response.should redirect_to(songs_url)
    end
  end

end

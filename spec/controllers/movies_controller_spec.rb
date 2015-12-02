require 'rails_helper'

RSpec.describe MoviesController, type: :controller do
  let (:movie) do
    Movie.create(name: "Test Movie", description: "Movie's description", director: "Movie's director")
  end

  describe "GET 'index'" do
    it "is successful" do
      get :index
      expect(response.status).to eq 200
    end
  end

  describe "GET 'show'" do
    it "renders the show view" do
      get :show, id: movie.id
      expect(subject).to render_template :show
    end
  end

  describe "GET 'new'" do
    it "renders new view" do
      get :new
      expect(subject).to render_template :new
    end
  end

  describe "POST 'create'" do
    let (:good_params) do
      {
        movie: { name: "Test Movie", description: "Movie's description", director: "Movie's director"
        }
      }
    end

    let (:bad_params) do
      {
        movie: { description: "Movie's description", director: "Movie's director"
        }
      }
    end

    it "redirects to show page" do
      post :create, good_params
      expect(subject).to redirect_to movie_path(assigns(:movie).id)
    end

    it "renders new template on error" do
      post :create, bad_params
      expect(subject).to render_template :new
    end
  end

  describe "GET 'edit'" do
    it "renders edit view" do
      get :edit, id: movie.id
      expect(subject).to render_template :edit
    end
  end

  describe "PATCH 'update'" do
    let (:good_params) do
      {
        id: movie.id,
        movie: { name: "zzzTest Movie", description: "zzzzMovie's description", director: "zzzMovie's director"
        }
      }
    end

    let (:bad_params) do
      {
        id: movie.id,
        movie: { name: "", description: "Movie's description", director: "Movie's director"
        }
      }
    end

    it "redirects to show page" do
      patch :update, good_params
      expect(subject).to redirect_to movie_path(movie)
      expect(Movie.find(movie.id).name).to eq "zzzTest Movie"
    end

    it "renders edit template on error" do
      patch :update, bad_params
      expect(subject).to render_template :edit
      expect(Movie.find(movie.id).name).to eq "Test Movie"
    end
  end

  describe "DELETE 'destroy'" do
    it "redirects to index page" do
      delete :destroy, id: movie.id
      expect(subject).to redirect_to movies_path
    end
  end

  describe "PATCH 'upvote'" do
    it "increases ranked by 1" do
      patch :upvote, id: movie.id
      expect(Movie.find(movie.id).ranked).to eq 1
    end

    it "redirects to show page" do
      patch :upvote, id: movie.id
      expect(subject).to redirect_to movie_path(movie)
    end
  end
end

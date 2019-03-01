defmodule IMDBTest do
  use ExUnit.Case
  doctest IMDB

  test "convert json string to map" do
    input = "{\"name\":\"Devin Torres\",\"age\":27}"
    expected = %{"age" => 27, "name" => "Devin Torres"}
    assert IMDB.movie_map(input) == expected
  end

  test "movie_id_titles with all keys" do
    input = %{"titles" => %{"movie-id"=> %{"primary"=> %{"title"=> "movie-title"}}}}
    expected =[%{"movie-id" => "movie-title"}]
    assert IMDB.movie_id_titles(input) == expected
  end

  test "missing key titles" do
    input = %{"missing-titles" => %{"movie-id"=> %{"primary"=> %{"title"=> "movie-title"}}}}
    assert_raise MatchError,  fn -> IMDB.movie_id_titles(input) end
  end

  test "missing primary key" do
    input = %{"titles" => %{"movie-id"=> %{"missing-primary"=> %{"title"=> "movie-title"}}}}
    assert_raise MatchError,  fn -> IMDB.movie_id_titles(input) end
  end

  test "missing title key" do
    input = %{"titles" => %{"movie-id"=> %{"primary"=> %{"missing-title"=> "movie-title"}}}}
    assert_raise MatchError,  fn -> IMDB.movie_id_titles(input) end
  end

end

# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Adze.Repo.insert!(%Adze.SomeModel{})
alias Adze.Repo
alias Adze.API.Sponsor

Repo.delete_all Sponsor
Repo.insert! %Sponsor{
  name: "Blue Apron",
  billing_info: "One Blue Apron, Blue Apron Street, Blue Apron State",
  notes: "Cook all the things!"
}

# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

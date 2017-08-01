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
alias Adze.API.Campaign

Repo.delete_all Sponsor
blue_apron = Repo.insert! %Sponsor{
  name: "Blue Apron",
  billing_info: "One Blue Apron, Blue Apron Street, Blue Apron State",
  notes: "Cook all the things!"
}

zip_recruiter = Repo.insert! %Sponsor{
  name: "ZipRecruiter",
  billing_info: "Probably online",
  notes: "One job, alllll the places"
}

ba_campaign = Repo.insert! %Campaign{
  sponsor_id: blue_apron.id,
  show_id: 4,
  start_date: Ecto.Date.cast!("2017-06-27"),
  end_date: Ecto.Date.cast!("2017-07-27"),
  copy: "Yay blue apron!",
  zone: "Preroll",
  repeat_sponsor: false
}

ba_campaign = Repo.insert! %Campaign{
  sponsor_id: zip_recruiter.id,
  show_id: 4,
  start_date: Ecto.Date.cast!("2017-06-27"),
  end_date: Ecto.Date.cast!("2017-07-27"),
  copy: "hire the people!",
  zone: "Midroll",
  repeat_sponsor: false
}


# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

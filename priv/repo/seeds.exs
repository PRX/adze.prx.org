# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Jingle.Repo.insert!(%Jingle.SomeModel{})
alias Jingle.Repo
alias Jingle.API.Sponsor
alias Jingle.API.Campaign
alias Jingle.API.Show
alias Jingle.API.Creative

Enum.each([Sponsor, Campaign, Show, Creative], fn f -> Repo.delete_all(f) end)

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

nnpi= Repo.insert! %Show{
  structure: "preroll preroll midroll postroll sonic_id",
  network: "Radiotopia",
  name: "99% Invincible",
  rate: "$10 CPM",
  notes: "No ads before 07/01/2016",
  recording_day: "Monday"
}

dogtalk = Repo.insert! %Show{
  structure: "preroll preroll midroll postroll sonic_id",
  network: "Dogs",
  name: "Dogtalk",
  rate: "$10 CPM",
  notes: "Prerolls only before 05/01/2017",
  recording_day: "Saturday"
}

ba_campaign = Repo.insert! %Campaign{
  sponsor_id: blue_apron.id,
  show_id: nnpi.id,
  start_date: Ecto.Date.cast!("2017-06-27"),
  end_date: Ecto.Date.cast!("2017-07-27"),
  copy: "Yay blue apron!",
  zone: "Preroll",
}

zip_campaign = Repo.insert! %Campaign{
  sponsor_id: zip_recruiter.id,
  show_id: dogtalk.id,
  start_date: Ecto.Date.cast!("2017-06-27"),
  end_date: Ecto.Date.cast!("2017-07-27"),
  copy: "hire the people!",
  zone: "Midroll"
}

ba_creative = Repo.insert! %Creative{
  campaign_id: ba_campaign.id,
  status: "complete",
  label: "Postroll 2 99pi Blue Apron",
  zone: "Postroll 2",
  filename: "dummy1"
}

zip_creative = Repo.insert! %Creative{
  campaign_id: zip_campaign.id,
  status: "complete",
  label: "Preroll 1 DogTalk Zip Recruiter",
  zone: "Preroll 1",
  filename: "dummy2"
}

# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

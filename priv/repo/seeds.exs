# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Jingle.Repo.insert!(%Jingle.SomeModel{})
alias Jingle.Repo
alias Jingle.Sponsor
alias Jingle.Campaign
alias Jingle.Podcast
alias Jingle.Creative

Enum.each([Sponsor, Campaign, Podcast, Creative], fn f -> Repo.delete_all(f) end)

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

nnpi= Repo.insert! %Podcast{
  structure: "preroll preroll midroll postroll sonic_id",
  network: "Radiotopia",
  name: "99% Invincible",
  rate: "$10 CPM",
  notes: "No ads before 07/01/2016",
  recording_day: "Monday"
}

dogtalk = Repo.insert! %Podcast{
  structure: "preroll preroll midroll postroll sonic_id",
  network: "Dogs",
  name: "Dogtalk",
  rate: "$10 CPM",
  notes: "Prerolls only before 05/01/2017",
  recording_day: "Saturday"
}

ba_campaign = Campaign.changeset(%Campaign{}, %{
  sponsor_id: blue_apron.id,
  podcast_id: nnpi.id,
  start_date: "2017-12-20T19:58:10.843080Z",
  end_date: "2017-12-30T19:58:10.843080Z",
  due_date: "2017-12-25T19:58:10.843080Z",
  original_copy: "Blue Apron Inc. is an American ingredient-and-recipe meal kit service. It exclusively operates in the United States.[1] The weekly boxes contain ingredients and also include suggested recipes that must be cooked by hand by the customer using the pre-ordered ingredients. Matt Salzberg, Ilia Papas and Matt Wadiak first began sending customers boxes containing the ingredients to cook multiple recipes in August 2012, packing and shipping the first 30 orders themselves from a commercial kitchen in Long Island City.",
  must_say: "Blue Apron dot com slash free trial",
  notes: "Currently promoted menu items include: wheatberry salad, raspberry chocolate",
  zone: "Preroll",
})
|> Repo.insert!

zip_campaign = Campaign.changeset(%Campaign{}, %{
  sponsor_id: zip_recruiter.id,
  podcast_id: dogtalk.id,
  start_date: "2017-12-20T19:58:10.843080Z",
  end_date: "2017-12-30T19:58:10.843080Z",
  due_date: "2017-12-25T19:58:10.843080Z",
  must_say: "Use offer code DogTalk to get 10% off your first posting",
  original_copy: "Over 8 Million Jobs! There's no need to look anywhere else. With over 8 million jobs, ZipRecruiter is the only site you'll ever need to find your next job.",
  notes: "If you use your offer code by Friday 1/3 you'll get double the points",
  zone: "Midroll"
})
|> Repo.insert!

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

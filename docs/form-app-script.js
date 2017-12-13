// This is the code behind the Google Form that is the first-round version of campaign creation: https://goo.gl/forms/aAcBrU408Kv2jrEr2

// TODO change these to prod URLs eventually
SPONSOR_URL = 'http://jingle.staging.prx.tech/api/v1/sponsors';
PODCAST_URL = 'http://jingle.staging.prx.tech/api/v1/podcasts';
CAMPAIGN_URL = 'http://jingle.staging.prx.tech/api/v1/campaigns';


function onSubmit(e){
  var attributes = {};

  // TODO should change this to pulling namedValues from the event instead of reading last line of spreadsheet of responses (the latter is easier for testing, for now)
  var formResponses = FormApp.getActiveForm().getResponses();
  var mostRecentResponse = formResponses[formResponses.length - 1];
  mostRecentResponse.getItemResponses().forEach(function(item) {
    attributes[item.getItem().getTitle()] = item.getResponse();
  });

  attributes["sponsor_id"] = getOrCreateSponsor(attributes).id;
  attributes["podcast_id"] = getOrCreatePodcast(attributes).id;

  createCampaign(attributes);
  setChoices(); // reset the answer choices for exising sponsor / podcast by pulling from jingle
}

function getOrCreateSponsor(attributes) {
  if (!attributes['Existing sponsor'].match(/\Other/)) {
    return {id: attributes['Existing sponsor'].split(':')[1].trim()}
  } else {
    var newSponsor = {
      sponsor: {
        name: attributes['New sponsor name'],
        billing_info: attributes['New sponsor billing information'],
        notes: attributes['Notes about new sponsor']
      }
    }
    var sponsorResponse = JSON.parse(postRequest(SPONSOR_URL, newSponsor).getContentText());
    return {id: sponsorResponse.id};
  }
}

function getOrCreatePodcast(attributes) {
  if (!attributes['Existing podcast'].match(/\Other/)) {
    return {id: attributes['Existing podcast'].split(':')[1].trim()}
  } else {
    var newPodcast = {
      podcast: {
        name: attributes['New podcast name'],
        network: attributes['New podcast network'],
        structure: attributes['New podcast show structure'],
        recording_day: attributes['New podcast recording day of week (if known)'],
        rate: attributes['New podcast rate'],
        notes: attributes['Notes about new podcast']
      }
    }
    var podcastResponse = JSON.parse(postRequest(PODCAST_URL, newPodcast).getContentText());
    return {id: podcastResponse.id};
  }
}

function createCampaign(attributes) {
  var newCampaign = {
    campaign: {
      start_date: attributes['Start date'],
      end_date: attributes['End date'],
      due_date: attributes['Due date'],
      original_copy: attributes['Copy'],
      must_say: attributes['Must Say'],
      notes: attributes['Notes'],
      zone: attributes['Zone(s)'].join(),
      sponsor_id: attributes['sponsor_id'],
      podcast_id: attributes['podcast_id']
    }
  }
  postRequest(CAMPAIGN_URL, newCampaign);
}

function postRequest(url, payload){
  var request = {
    method: 'post',
    contentType: 'application/json',
    payload:  JSON.stringify(payload)
  };
  return UrlFetchApp.fetch(url, request);
}

// code below handles the setting of the "existing podcast" and "existing sponsor" choices to match what's in Jingle
// TODO should change these to pull from Adzerk sites + advertizers (networks too)


function setChoices() {
  var questions = FormApp.getActiveForm().getItems();
  questions.forEach(function (question) {
    if (question.getTitle() == "Existing sponsor" && question.getType() == FormApp.ItemType.MULTIPLE_CHOICE) {
      setAnswerChoices(question.asMultipleChoiceItem(), SPONSOR_URL);
    }
    if (question.getTitle() === "Existing podcast" && question.getType() == FormApp.ItemType.MULTIPLE_CHOICE) {
      setAnswerChoices(question.asMultipleChoiceItem(), PODCAST_URL);
    }
  });
}

function setAnswerChoices(question, url){
  var titlesAndIds = fetchJingleResources(url).map(function (r) { return r.name + ": " + r.id });
  question.setChoiceValues(titlesAndIds.concat('Other (enter new info below)'));
}

function fetchJingleResources(url){
  return JSON.parse(UrlFetchApp.fetch(url).getContentText())["_embedded"]["prx:items"].map(function (el) {
    return {
      id: el.id,
      name: el.name
    };
  });
}

// ran this once to set up the recurring trigger
function createTimeTrigger() {
  ScriptApp.newTrigger('setChoices')
  .timeBased()
  .everyHours(1)
  .create();
}

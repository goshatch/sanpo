// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require jquery_ujs
//= require jquery.purr
//= require best_in_place
//= require_tree .
$('.topbar').dropdown();

$('.topbar .brand').click(function(event) {
  _gaq.push(['_trackEvent', 'TopNavigation', 'logo clicked'])
});
$('.topbar .registrationLink a').click(function(event) {
  _gaq.push(['_trackEvent', 'TopNavigation', 'registration link clicked'])
});
$('.topbar .signinLink a').click(function(event) {
  _gaq.push(['_trackEvent', 'TopNavigation', 'signin link clicked'])
});
$('.topbar .accountDropdownToggle').click(function(event) {
  _gaq.push(['_trackEvent', 'TopNavigation', 'account dropdown toggled'])
});
$('.topbar .editAccountLink a').click(function(event) {
  _gaq.push(['_trackEvent', 'TopNavigation', 'edit account link toggled'])
});
$('.topbar .signoutLink a').click(function(event) {
  _gaq.push(['_trackEvent', 'TopNavigation', 'sign out link clicked'])
});
$('.topbar .recentWalksLink a').click(function(event) {
  _gaq.push(['_trackEvent', 'TopNavigation', 'recent walks button clicked'])
});
$('.topbar .newWalkLink a').click(function(event) {
  _gaq.push(['_trackEvent', 'TopNavigation', 'new walk link clicked'])
});
$('.topbar .blogLink a').click(function(event) {
  _gaq.push(['_trackEvent', 'TopNavigation', 'blog link clicked'])
});
$('#walkPageUploadPhotoButton').click(function(event) {
  _gaq.push(['_trackEvent', 'WalkPage', 'upload photo button clicked'])
});
$('#walkPageGalleryButton').click(function(event) {
  _gaq.push(['_trackEvent', 'WalkPage', 'gallery button clicked'])
});
$('#mapLocationSearchForm').submit(function(event) {
  _gaq.push(['_trackEvent', 'WalkPage', 'new walk: geocoding form submitted'])
});
$('#mapLocationSearchForm').submit(function(event) {
  _gaq.push(['_trackEvent', 'Goal tracking', 'Account created']);
});
$('.commentFormSignInButton').click(function(event) {
  _gaq.push(['_trackEvent', 'WalkPage', 'Comment sign in button clicked'])
});
$('.commentFormSignUpButton').click(function(event) {
  _gaq.push(['_trackEvent', 'WalkPage', 'Comment sign up button clicked'])
});

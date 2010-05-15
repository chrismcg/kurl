Feature: Easy download

  As a developer
  I want to download a url to a file
  So I can have a local copy of the file to work with

  Scenario: Download file
    Given A url "/test?size=1024" and a filename "1024.txt"
    When I download the url
    Then the contents of the url should be saved to the file identified by the filename

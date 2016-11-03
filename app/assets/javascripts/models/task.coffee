# for more details see: http://emberjs.com/guides/models/defining-models/

CircularWorks.Task = DS.Model.extend
  title: DS.attr 'string'
  description: DS.attr 'string'
  recurrence: DS.attr 'number'
  recurrenceMatch: DS.attr 'string'
  email: DS.attr 'string'
  notificationSubject: DS.attr 'string'
  notificationBody: DS.attr 'string'

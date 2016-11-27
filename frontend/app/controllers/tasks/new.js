import Ember from 'ember';

export default Ember.Controller.extend({
  recurrenceOptions: [
    Ember.Object.create({ value: 0, label: "Daily" }),
    Ember.Object.create({ value: 1, label: "weekly" }),
    Ember.Object.create({ value: 2, label: "Montly" }),
    Ember.Object.create({ value: 3, label: "Yearly" })
  ],
  recurrenceMatchPositions: [
    Ember.Object.create({ value: 0, label: "First" }),
    Ember.Object.create({ value: 1, label: "Second" }),
    Ember.Object.create({ value: 2, label: "Third" }),
    Ember.Object.create({ value: 3, label: "Fourth" }),
    Ember.Object.create({ value: 4, label: "Last" })
  ],
  recurrenceMatchDays: [
    Ember.Object.create({ value: 0, label: "Monday" }),
    Ember.Object.create({ value: 1, label: "Tuesday" }),
    Ember.Object.create({ value: 2, label: "Wednesday" }),
    Ember.Object.create({ value: 3, label: "Thursday" }),
    Ember.Object.create({ value: 4, label: "Friday" }),
    Ember.Object.create({ value: 5, label: "Saturday" }),
    Ember.Object.create({ value: 6, label: "Sunday" })
  ]
});

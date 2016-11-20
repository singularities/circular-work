import Ember from 'ember';

export default Ember.Controller.extend({
  recurrenceOptions: [
    Ember.Object.create({ value: 0, label: "No recurrence" }),
    Ember.Object.create({ value: 1, label: "Daily" }),
    Ember.Object.create({ value: 2, label: "weekly" }),
    Ember.Object.create({ value: 3, label: "Montly" }),
    Ember.Object.create({ value: 4, label: "Yearly" }),
  ]
});

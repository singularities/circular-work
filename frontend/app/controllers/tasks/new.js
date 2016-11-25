import Ember from 'ember';

export default Ember.Controller.extend({
  recurrenceOptions: [
    Ember.Object.create({ value: 0, label: "Daily" }),
    Ember.Object.create({ value: 1, label: "weekly" }),
    Ember.Object.create({ value: 2, label: "Montly" }),
    Ember.Object.create({ value: 3, label: "Yearly" }),
  ]
});

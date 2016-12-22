import Ember from 'ember';

const options = [
// Recurrence is currently implemented for weeks and months
//  Ember.Object.create({ value: 0, label: "daily" }),
  Ember.Object.create({ value: 1, label: "weekly" }),
  Ember.Object.create({ value: 2, label: "monthly" })
//  Ember.Object.create({ value: 3, label: "yearly" })
];

export default options;

// src/models/VerificationCode.js
const { DataTypes } = require('sequelize');
const sequelize = require('../config/dbConfig');

const VerificationCode = sequelize.define('VerificationCode', {
  email: {
    type: DataTypes.STRING,
    allowNull: false,
  },
  code: {
    type: DataTypes.STRING,
    allowNull: false,
  },
  expiresAt: {
    type: DataTypes.DATE,
    allowNull: false,
  },
}, {
  tableName: 'verification_codes',
  timestamps: true,
});

module.exports = VerificationCode;
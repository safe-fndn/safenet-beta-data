# safenet-beta-data

Data and JSON files for Safenet Beta. Contains network stats, validator info, and rewards distribution data.

> **Pre-launch:** This repo currently contains test data only.

> **Auto-updates:** Automated updates have not been fully implemented yet. Once live, `networks.json` and `validator_info` will be updated automatically. Rewards data is updated manually, on a regular basis, if SafeDAO approves proposal for rewards distribution.

---

## networks.json

Aggregate network-level stats for Safenet Beta.

```json
{
  "total_staked_amount": 123123.12331221,
  "total_transactions_checked": 88764457
}
```

#### `total_staked_amount`

Total SAFE tokens currently staked, as a number with up to 18 decimal places. Sourced from the staking contract at [`0x115E78f160e1E3eF163B05C84562Fa16fA338509`](https://etherscan.io/address/0x115E78f160e1E3eF163B05C84562Fa16fA338509#code) on Ethereum mainnet.

#### `total_transactions_checked`

A monotonically increasing integer counting all `TransactionProposed` events since inception. Sourced from the consensus contract (not yet deployed).

---

## validator_info

See [`assets/safenet-validator-info.json`](./assets/safenet-validator-info.json) for current data.

#### `address`

Ethereum address of the validator.

```json
"address": "0x1111111111111111111111111111111111111111"
```

#### `label`

Human-readable display name for the validator.

```json
"label": "Validator A"
```

#### `commission`

Commission percentage applied to any possible rewards.

```json
"commission": 0.05
```

#### `is_active`

`true` if the validator has issued any signing event within the last 1h, `false` otherwise.

```json
"is_active": true
```

#### `participation_rate_14d`

Average participation rate (%) over the last 14 days. Computed by joining `SignCompleted` events with `SignShared` on `selection_root` and measuring the validator's participation rate across those events.

```json
"participation_rate_14d": 0.8523
```

---

## rewards

Merkle proofs and associated data required for Safenet Beta rewards distribution, should SafeDAO vote to approve a rewards proposal. Updated manually if there is an approved SafeDAO proposal for rewards.

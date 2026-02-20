# Safenet Beta Validator Info

Repo to host and update Safenet Beta validator.

See [safenet-validator-info.json](./assets/safenet-validator-info.json) for current data.

### Fields:

#### Validator address

```json
"address": "0x1111111111111111111111111111111111111111"
```

#### Validator display label

```json
"label": "Validator A"
```

#### Commission % on possible rewards

```json
"commission": 0.05
```

#### Activity indicator

`true` if the validator has been issuing any signing event within the last 1h. `false` otherwise.

```json
"is_active": true
```

#### Average participation rate (%) during the last 14d

Takes all `SignCompleted` events, joins with `SignShared` on `selection_root` and checks the participation rate of the validator in these.

```json
"participation_rate_14d": 0.8523
```

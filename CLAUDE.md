# CLAUDE.md — safenet-beta-data

Guidelines for working on this repository with Claude.

## Repository purpose

This repo stores and serves JSON data for Safenet Beta: network-level stats, validator info, and rewards distribution data. It is consumed by frontends and other tooling that rely on stable file paths and predictable schemas.

## Key files

- `networks.json` — aggregate network stats (staked SAFE, total transactions checked)
- `assets/safenet-validator-info.json` — per-validator data
- `rewards/` — merkle proofs and distribution data for SafeDAO-approved rewards proposals

## Data integrity rules

- **Never break existing JSON schemas.** Consumers depend on field names and types being stable. Adding new optional fields is fine; removing or renaming fields is a breaking change.
- **Validate JSON before committing.** All JSON files must be valid and well-formed. Use `python3 -m json.tool <file>` or `jq . <file>` to verify.
- **Numbers, not strings, for numeric values.** `total_staked_amount` and similar fields must remain JSON numbers, not quoted strings.
- **Monotonic counters must never decrease.** `total_transactions_checked` only goes up; never write a lower value than what is already present.
- **Preserve decimal precision.** `total_staked_amount` supports up to 18 decimal places; do not round unless explicitly instructed.

## Update cadence

- `networks.json` and `validator_info` — will be auto-updated once automation is in place (not yet implemented).
- `rewards/` — updated manually, following an approved SafeDAO rewards distribution proposal only.

## Pre-launch note

Until the official Safenet Beta launch, all data in this repo is test data. Do not treat any values as production figures.

## On-chain sources

| Data | Contract | Network |
|------|----------|---------|
| `total_staked_amount` | [`0x115E78f160e1E3eF163B05C84562Fa16fA338509`](https://etherscan.io/address/0x115E78f160e1E3eF163B05C84562Fa16fA338509#code) | Ethereum mainnet |
| `total_transactions_checked` | Consensus contract (not yet deployed) | TBD |

## Commit hygiene

- Keep commits focused: one logical change per commit.
- Commit messages should state what changed and why (e.g. `chore: update networks.json with latest staking snapshot`).
- Do not commit secrets, private keys, or internal infrastructure URLs.

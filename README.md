# payment-router

A small Solidity project for building a stablecoin payment flow one step at a time. The intended MVP is a single router holding one fixed ERC-20 token between payment and settlement. **That router does not exist yet.**

## Current status

Only the payment data model is implemented in [`src/Payment.sol`](src/Payment.sol). It contains two top-level declarations:

| Type | Definition |
| --- | --- |
| `PaymentStatus` | `None`, `Created`, `Paid`, `Settled`, in that order |
| `Payment` | `merchant: address`, `payer: address`, `amount: uint256`, `status: PaymentStatus` |

`None` is the enum's zero value. A default-initialized `Payment` therefore has zero-valued fields and `status == None`, rather than appearing to be `Created`. There is no storage mapping or payment ID counter yet, so payments cannot currently be created or queried.

`amount` is intended to represent the token's smallest units, not a human-readable token amount. No token is configured in the code at this stage. The `payer` field is just data for now; assigning it when someone pays is future behavior, not an implemented guarantee.

## Intended MVP flow (not implemented)

1. A merchant creates a payment for a positive amount; the merchant will be the caller.
2. A customer approves the router to spend the fixed token and pays. The router will hold the tokens, and the payment will move from `Created` to `Paid`.
3. The merchant settles the payment. The router will transfer the held tokens to the merchant, and the payment will move from `Paid` to `Settled`.

The intended state transitions are `None → Created → Paid → Settled`. The current file defines these names but **does not enforce any transition or move funds**. Refunds, expiration, fees, signatures, and multi-token support are outside the initial MVP.

## Compile the current source

The source pins Solidity **0.8.37**. With Node.js and npm available, run from the repository root:

```sh
npx --yes solc@0.8.37 --version
npx --yes solc@0.8.37 --bin src/Payment.sol
```

The second command checks compilation and exits successfully without producing deployable bytecode: the source contains only an enum and a struct, not a contract. There is currently no project test suite or CI workflow; compilation is the available smoke check.

## Next step

Add storage keyed by a monotonically increasing payment ID, then implement creation and its first unit test. Payment, escrow, and settlement logic come later.

## License

MIT; see [LICENSE](LICENSE).

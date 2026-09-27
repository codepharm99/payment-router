// SPDX-License-Identifier: MIT
pragma solidity 0.8.37;

enum PaymentStatus {
    None,
    Created,
    Paid,
    Settled
}

struct Payment {
    address merchant;
    address payer;
    uint256 amount;
    PaymentStatus status;
}

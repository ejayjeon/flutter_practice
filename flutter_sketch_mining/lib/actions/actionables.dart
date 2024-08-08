enum Actionables {
  manualTest,
  autoTest,
  mineFreeGasInit,
  mineFreeGasProc,
  mineFreeGasCpl,
  sendTxWithoutSFuel,
  createSignedBulkTx,
  mineAndSendFreeTx,
  startMiningReserves,
  devShowStats,
  devUpdate,
  undefined
}

typedef RunnableUserAction = void Function();
typedef UnaryUserAction<T> = void Function(T t);
typedef BinaryUserAction<T, S> = void Function(T t, S s);
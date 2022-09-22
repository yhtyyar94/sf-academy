AccountNumsUpdateBatch batchable = new AccountNumsUpdateBatch();
Database.executeBatch(batchable, 100);
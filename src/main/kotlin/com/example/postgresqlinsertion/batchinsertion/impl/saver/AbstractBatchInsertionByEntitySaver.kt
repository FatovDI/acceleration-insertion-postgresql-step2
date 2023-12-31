package com.example.postgresqlinsertion.batchinsertion.impl.saver

import com.example.postgresqlinsertion.batchinsertion.api.saver.BatchInsertionByEntitySaver
import com.example.postgresqlinsertion.logic.entity.BaseEntity
import java.sql.Connection

abstract class AbstractBatchInsertionByEntitySaver<E : BaseEntity>(
    conn: Connection,
    private val batchSize: Int
) : AbstractBatchInsertionSaver(conn), BatchInsertionByEntitySaver<E> {

    private var counter = 0

    override fun addDataForSave(entity: E) {
        counter++
        if (counter % batchSize == 0) {
            log.info("save batch insertion $batchSize")
            saveData()
        }
    }

    override fun commit() {
        if (counter % batchSize != 0) {
            saveData()
        }
        log.info("start commit $counter data")
        counter = 0
        super.commit()
    }
}
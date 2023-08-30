package com.example.postgresqlinsertion.batchinsertion.impl.factory

import com.example.postgresqlinsertion.batchinsertion.api.factory.BatchInsertionByEntityFactory
import com.example.postgresqlinsertion.batchinsertion.api.factory.SaverType
import com.example.postgresqlinsertion.batchinsertion.api.processor.BatchInsertionByEntityProcessor
import com.example.postgresqlinsertion.batchinsertion.api.saver.BatchInsertionByEntitySaver
import com.example.postgresqlinsertion.batchinsertion.impl.saver.*
import com.example.postgresqlinsertion.logic.entity.BaseEntity
import javax.sql.DataSource
import kotlin.reflect.KClass

abstract class BatchInsertionByEntityFactory<E: BaseEntity>(
    private val entityClass: KClass<E>,
    override val processor: BatchInsertionByEntityProcessor,
    private val dataSource: DataSource,
) : BatchInsertionByEntityFactory<E> {

    override fun getSaver(type: SaverType): BatchInsertionByEntitySaver<E> {

        return when (type) {
            SaverType.COPY -> CopyByEntitySaver(processor, entityClass, dataSource)
            SaverType.COPY_BINARY -> CopyBinaryByEntitySaver(processor, entityClass, dataSource)
            SaverType.COPY_VIA_FILE -> CopyViaFileByEntitySaver(processor, entityClass, dataSource)
            SaverType.COPY_BINARY_VIA_FILE -> CopyBinaryViaFileByEntitySaver(processor, entityClass, dataSource)
            SaverType.INSERT -> InsertByEntitySaver(processor, entityClass, dataSource)
            SaverType.UPDATE -> UpdateByEntitySaver(processor, entityClass, dataSource)
        }

    }
}

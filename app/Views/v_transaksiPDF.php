<h1>Data Transaksi</h1>

<table border="1" width="100%" cellpadding="5">
    <tr>
        <th>No</th>
        <th>Username</th>
        <th>Total Harga</th>
        <th>Alamat</th>
        <th>Ongkir</th>
        <th>Status</th>
        <th>Aksi</th>
    </tr>

    <?php
    $counter = 1;
    if (!empty($transaction)) :
        foreach ($transaction as $transaksi) :
    ?>
        <tr>
            <td><?= $counter ?></td> <!-- Menampilkan nomor urut -->
            <td><?= $transaksi['username'] ?></td>
            <td><?= number_to_currency($transaksi['total_harga'], 'IDR') ?></td>
            <td><?= $transaksi['alamat'] ?></td>
            <td><?= number_to_currency($transaksi['ongkir'], 'IDR') ?></td>
            <td><?= $transaksi['status'] ?></td>
        </tr>
    <?php
        $counter++;
        endforeach;
    endif;
    ?>
</table>
Downloaded on <?= date("Y-m-d H:i:s") ?>
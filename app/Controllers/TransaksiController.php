<?php

namespace App\Controllers;

use App\Models\UserModel;
use App\Models\TransactionModel;
use App\Models\TransactionDetailModel;
use Dompdf\Dompdf;
use Dompdf\Options;

class TransaksiController extends BaseController
{
    protected $cart;
    protected $url = "https://api.rajaongkir.com/starter/";
    protected $apiKey = "e45165a822b8051f6cd00b38babaa258";
    protected $transaction;
    protected $transaction_detail;

    function __construct()
    {
        helper('number');
        helper('form');
        $this->cart = \Config\Services::cart();
        $this->transaction = new TransactionModel();
        $this->transaction_detail = new TransactionDetailModel();
    }

    public function index()
    {
        $data['items'] = $this->cart->contents();
        $data['total'] = $this->cart->total();
        return view('v_keranjang', $data);
    }

    function curl($endpoint, $params = '')
{
    $url = 'https://yourapiurl.com/api/' . $endpoint;
    $ch = curl_init();
    curl_setopt($ch, CURLOPT_URL, $url);
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
    curl_setopt($ch, CURLOPT_POST, 1);
    curl_setopt($ch, CURLOPT_POSTFIELDS, $params);
    curl_setopt($ch, CURLOPT_HTTPHEADER, [
        'Key: e45165a822b8051f6cd00b38babaa258',
        'Content-Type: application/x-www-form-urlencoded'
    ]);
    $response = curl_exec($ch);
    
    if (curl_errno($ch)) {
        echo 'Curl error: ' . curl_error($ch);
    }
    curl_close($ch);

    echo '<pre>Response: ' . htmlspecialchars($response) . '</pre>'; // Debug output

    return json_decode($response);
}

    public function transactionindex()
    {
        $transaction = $this->transaction;
        $data['transaction'] = $this->transaction->findAll();
        return view('v_transaksi', $data);
    }
    
    public function transaction_edit($id = null)
{
    // Get the status from POST data
    $status = $this->request->getPost('status');

    if ($id !== null) {
        // Find the transaction by ID
        $transaction = $this->transaction->find($id);

        if ($transaction) {
            // Update the transaction status
            $data = ['status' => $status];
            $this->transaction->update($id, $data);

            session()->setFlashdata('success', 'Status transaksi berhasil diubah.');
        } else {
            session()->setFlashdata('error', 'Transaksi tidak ditemukan.');
        }
    } else {
        session()->setFlashdata('error', 'ID transaksi tidak valid.');
    }

    return redirect()->to(base_url('transaction'));
}
    
    public function cart_add()
    {
        $this->cart->insert(array(
            'id'        => $this->request->getPost('id'),
            'qty'       => 1,
            'price'     => $this->request->getPost('harga'),
            'name'      => $this->request->getPost('nama'),
            'options'   => array('foto' => $this->request->getPost('foto'))
        ));
        session()->setflashdata('success', 'Produk berhasil ditambahkan ke keranjang. (<a href="' . base_url() . 'keranjang">Lihat</a>)');
        return redirect()->to(base_url('/'));
    }

    public function cart_clear()
    {
        $this->cart->destroy();
        session()->setflashdata('success', 'Keranjang Berhasil Dikosongkan');
        return redirect()->to(base_url('keranjang'));
    }

    public function cart_edit()
    {
        $i = 1;
        foreach ($this->cart->contents() as $value) {
            $this->cart->update(array(
                'rowid' => $value['rowid'],
                'qty'   => $this->request->getPost('qty' . $i++)
            ));
        }

        session()->setflashdata('success', 'Keranjang Berhasil Diedit');
        return redirect()->to(base_url('keranjang'));
    }

    public function cart_delete($rowid)
    {
        $this->cart->remove($rowid);
        session()->setflashdata('success', 'Keranjang Berhasil Dihapus');
        return redirect()->to(base_url('keranjang'));
    }

    public function checkout()
    {
        $data['items'] = $this->cart->contents();
        $data['total'] = $this->cart->total();
        $provinsi = $this->rajaongkir('province');
				$data['provinsi'] = json_decode($provinsi)->rajaongkir->results;

        return view('v_checkout', $data);
    }

    public function getCity()
    {
        if ($this->request->isAJAX()) {
            $id_province = $this->request->getGet('id_province');
            $data = $this->rajaongkir('city', $id_province);
            return $this->response->setJSON($data);
        }
    }

    public function getCost()
    {
        if ($this->request->isAJAX()) {
            $origin = $this->request->getGet('origin');
            $destination = $this->request->getGet('destination');
            $weight = $this->request->getGet('weight');
            $courier = $this->request->getGet('courier');
            $data = $this->rajaongkircost($origin, $destination, $weight, $courier);
            return $this->response->setJSON($data);
        }
    }

    private function rajaongkircost($origin, $destination, $weight, $courier)
    {
        $curl = curl_init();

        curl_setopt_array($curl, array(
            CURLOPT_URL => "https://api.rajaongkir.com/starter/cost",
            CURLOPT_RETURNTRANSFER => true,
            CURLOPT_ENCODING => "",
            CURLOPT_MAXREDIRS => 10,
            CURLOPT_TIMEOUT => 30,
            CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
            CURLOPT_CUSTOMREQUEST => "POST",
            CURLOPT_POSTFIELDS => "origin=" . $origin . "&destination=" . $destination . "&weight=" . $weight . "&courier=" . $courier,
            CURLOPT_HTTPHEADER => array(
                "content-type: application/x-www-form-urlencoded",
                "key: " . $this->apiKey,
            ),
        ));

        $response = curl_exec($curl);
        $err = curl_error($curl);

        curl_close($curl);

        return $response;
    }


    private function rajaongkir($method, $id_province = null)
    {
        $endPoint = $this->url . $method;

        if ($id_province != null) {
            $endPoint = $endPoint . "?province=" . $id_province;
        }

        $curl = curl_init();

        curl_setopt_array($curl, array(
            CURLOPT_URL => $endPoint,
            CURLOPT_RETURNTRANSFER => true,
            CURLOPT_ENCODING => "",
            CURLOPT_MAXREDIRS => 10,
            CURLOPT_TIMEOUT => 30,
            CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
            CURLOPT_CUSTOMREQUEST => "GET",
            CURLOPT_HTTPHEADER => array(
                "key: " . $this->apiKey
            ),
        ));

        $response = curl_exec($curl);
        $err = curl_error($curl);

        curl_close($curl);

        return $response;
    }

    public function buy()
{
    if ($this->request->getPost()) { 
        $dataForm = [
            'username' => $this->request->getPost('username'),
            'total_harga' => $this->request->getPost('total_harga'),
            'alamat' => $this->request->getPost('alamat'),
            'ongkir' => $this->request->getPost('ongkir'),
            'status' => 0,
            'created_at' => date("Y-m-d H:i:s"),
            'updated_at' => date("Y-m-d H:i:s")
        ];

        $this->transaction->insert($dataForm);

        $last_insert_id = $this->transaction->getInsertID();

        foreach ($this->cart->contents() as $value) {
            $dataFormDetail = [
                'transaction_id' => $last_insert_id,
                'product_id' => $value['id'],
                'jumlah' => $value['qty'],
                'diskon' => 0,
                'subtotal_harga' => $value['qty'] * $value['price'],
                'created_at' => date("Y-m-d H:i:s"),
                'updated_at' => date("Y-m-d H:i:s")
            ];

            $this->transaction_detail->insert($dataFormDetail);
        }

        $this->cart->destroy();
 
        return redirect()->to(base_url('profile'));
    }
}

public function transaction_download()
{
    // Fetch all transactions
    $transaction = $this->transaction->findAll();

    // Load the view into a variable
    $html = view('v_transaksiPDF', ['transaction' => $transaction]);

    // Create a unique filename based on the current timestamp
    $filename = date('Y-m-d-H-i-s') . '-transaction.pdf';

    // Instantiate the Dompdf class
    $dompdf = new Dompdf();

    // Load HTML content
    $dompdf->loadHtml($html);

    // Set paper size and orientation
    $dompdf->setPaper('A4', 'portrait');

    // Render the HTML as PDF
    $dompdf->render();

    // Stream the generated PDF to the browser
    $dompdf->stream($filename, [
        'Attachment' => 1 // Set to 1 for download, 0 to display inline
    ]);

    // Uncomment below if you have issues with direct download and need to force headers
    // header('Content-Type: application/pdf');
    // header('Content-Disposition: attachment; filename="' . $filename . '"');
    // header('Content-Transfer-Encoding: binary');
    // header('Content-Length: ' . strlen($dompdf->output()));
    // echo $dompdf->output();
}

}
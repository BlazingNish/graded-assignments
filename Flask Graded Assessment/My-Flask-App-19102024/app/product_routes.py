from flask import Blueprint, render_template, redirect, request

product_routes = Blueprint('product_routes', __name__)

products = []

@product_routes.route('/products')
def home():
    return render_template('/products/index.html', title='Products', products=products)

@product_routes.route('/products/create', methods=['GET', 'POST'])
def create():
    if request.method == 'POST':
        product = {
            'id': request.form['id'],
            'name': request.form['name'],
            'price': request.form['price']
        }
        products.append(product)
        return redirect('/products')
    return render_template('/products/create.html', title='Create Product')


@product_routes.route('/products/update/<int:product_id>', methods=['GET', 'POST'])
def update(product_id):


    if request.method == 'POST':
        updated_product = {
            'id': request.form['id'], 'name': request.form['name'], 'price': request.form['price']}
        if updated_product:
            products[product_id-1] = updated_product
            print(products)
            return redirect('/products')
    return render_template('products/update.html', product=products[product_id-1], product_id=product_id)

@product_routes.route('/products/delete/<int:product_id>')
def delete(product_id):
    products.pop(product_id-1)
    return redirect('/products')

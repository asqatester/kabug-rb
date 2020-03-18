# frozen_string_literal: true

Dado('que acesso a página Login') do
  find('span', text: 'Minha conta').click
  find('a', text: 'Acessar').click
end

Quando('eu submeto as minhas credenciais {string} e {string}') do |email, senha|
  @email = email
  @senha = senha
  find('#input-email').set(@email)
  find('#input-password').set(@senha)
    find('input[value=Acessar]').click
end

Então('devo ver a seguinte mensagem de alerta: {string}') do |alert_message|
  expect(page).to have_text alert_message
end

Dado('que encontrei o {string} no catálogo') do |product|
  @product = product
  within('#search') do
    find('input[name=search]').set @product
    find('button').click
  end
  expect(page).to have_css('.product-thumb', text: @product)
end

Dado('entrei na página de detalhes deste produto') do
  find('a', text: @product).click
end

Quando('eu adiciono este item ao carrinho') do
  within('#product') do
    click_on 'Comprar'
  end
end

Então('vejo a mensagem: {string}') do |expect_message|
  expect(page).to have_text expect_message
end

Dado('que adicionei os seguintes itens no meu carrinho:') do |table|
  @product_list = table.hashes

  @product_list.each do |product|
    steps %(
      Dado que encontrei o '#{product['item']}' no catálogo
        E entrei na página de detalhes deste produto
      Quando eu adiciono este item ao carrinho
    )
  end
end

Quando('eu entro no meu carrinho de compras') do
  within('#top') do
    click_on 'Carrinho de compras'
  end
end

Quando('coloco meu cupom {string} com {int}% de desconto') do |coupon_code, _int|
  within('#accordion') do
    click_on 'Utilizar cupom'
    find('#input-coupon').set coupon_code
    find('#button-coupon').click
  end
end

Então('o valor total da minha compra deve ser de {string}') do |discount|
  total = find('tr', text: 'Total:')
  expect(total).to have_text discount
end
